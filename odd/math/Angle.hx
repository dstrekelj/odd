package odd.math;

class Angle
{
    // 180 / Math.PI
    static inline var RAD_TO_DEG : Float = 57.2957795131;
    // Math.PI / 180
    static inline var DEG_TO_RAD : Float = 0.0174532925;
    
    public static inline function deg(rad : Float) : Float
    {
        return rad * RAD_TO_DEG;
    }
    
    public static inline function rad(deg : Float) : Float
    {
        return deg * DEG_TO_RAD;
    }
}