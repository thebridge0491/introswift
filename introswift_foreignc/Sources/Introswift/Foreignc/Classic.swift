import Foundation

import classic_c

public class Classic {
	public class func factLp(_ n: Int) -> Int {
	    return classic_c.fact_lp(n)
	}

	public class func factI(_ n: Int) -> Int {
	    return classic_c.fact_i(n)
	}

	public class func exptLp(_ b: Float, _ n: Float) -> Float {
	    return classic_c.expt_lp(b, n)
	}

	public class func exptI(_ b: Float, _ n: Float) -> Float {
	    return classic_c.expt_i(b, n)
	}
}
