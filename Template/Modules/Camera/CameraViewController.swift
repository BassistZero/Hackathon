import UIKit
import AVFoundation

final class CameraViewController: UIViewController {

    // MARK: - Override Properties

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    // MARK: - Private Properties

    private var captureSession: AVCaptureSession!
    private var previewLayer: AVCaptureVideoPreviewLayer!

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if captureSession?.isRunning == false {
            captureSession.startRunning()
        }
    }

}

// MARK: - Configuration

private extension CameraViewController {

    func setupInitialState() {
        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch { return }

        guard captureSession.canAddInput(videoInput) else { failed(); return }

        captureSession.addInput(videoInput)

        //Initialize an AVCaptureMetadataOutput object and set it as the output device to the capture session.
        let metadataOutput = AVCaptureMetadataOutput()

        guard captureSession.canAddOutput(metadataOutput) else { failed(); return }

        captureSession.addOutput(metadataOutput)

        //Set delegate and use default dispatch queue to execute the call back
        metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417]

        //Initialize the video preview layer and add it as a sublayer.
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)

        //Start video capture
        DispatchQueue.main.async { [weak self] in
            self?.captureSession.startRunning()
        }
    }

}

// MARK: - AVCaptureMetadataOutputObjectsDelegate

extension CameraViewController: AVCaptureMetadataOutputObjectsDelegate {

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let metadataObject = metadataObjects.first else { return }
        guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
        guard let stringValue = readableObject.stringValue else { return }
        
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        found(code: stringValue)
    }

}

// MARK: - Private Methods

private extension CameraViewController {

    func failed() {
        let ac = UIAlertController(title: .localized(key: "Camera.alert.title"), message: .localized(key: "Camera.alert.message"), preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: .localized(key: "Camera.alert.ok"), style: .default))
        present(ac, animated: true)
        captureSession = nil
    }

    func found(code: String) {
        let controller = DetailViewController()

        controller.barCode = code
        present(controller, animated: true)
    }

}
