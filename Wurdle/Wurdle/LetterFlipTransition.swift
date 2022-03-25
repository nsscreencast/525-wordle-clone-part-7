import SwiftUI

extension AnyTransition {
    static func letterFlip(_ position: Int) -> AnyTransition {
        .modifier(active: LetterFlipTransition(percent: 0),
                  identity: LetterFlipTransition(percent: 1))
        .combined(with: .scale)
        .animation(.spring(response: 0.7, dampingFraction: 0.6, blendDuration: 0)
                    .delay(0.2 * CGFloat(position)))
    }
}

struct LetterFlipTransition: GeometryEffect {
    var percent: Double

    var animatableData: Double {
        get { percent }
        set { percent = newValue }
    }

    func effectValue(size: CGSize) -> ProjectionTransform {
        let rotationInRadians = CGFloat(Angle(degrees: 180 * (1-percent)).radians)

        var transform = CATransform3DIdentity
        transform = CATransform3DTranslate(transform, 0, size.height/2, 0)
        transform.m34 = -0.003
        transform = CATransform3DRotate(transform, rotationInRadians, 1, 0, 0)
        transform = CATransform3DTranslate(transform, 0, -size.height/2, 0)
        return ProjectionTransform(transform)
    }
}
