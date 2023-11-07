{unwrapped, getOverrides}: [
  {
    suffix = "19_0_720";
    overriddenVersion = (super: {
      unwrapped = unwrapped (
        getOverrides "19.0.720" "9.3" "d580ab699a13bae0f4d096dc090013b27095ca6ef9f3ff65d4be824ab30f4256"
      );
    });
  }
  {
    suffix = "19_5_569";
    overriddenVersion = (super: {
      unwrapped = unwrapped (
        getOverrides "19.5.569" "9.3" "0c2d6a31c24f5e7229498af6c3a7cdf81242501d7a0792e4c33b53a898d4999e"
      );
    });
  }
  {
    suffix = "19_5_640";
    overriddenVersion = (super: {
      unwrapped = unwrapped (
        getOverrides "19.5.640" "9.3" "37ffda14340a66dab9243885a4a4b138a6d61a1008732f664a053c37790146a4"
      );
    });
  }
  {
    suffix = "19_5_716";
    overriddenVersion = (super: {
      unwrapped = unwrapped (
        getOverrides "19.5.716" "9.3" "b9177d5432d44de5aed7b266d2af435ac8a294d9654fb1915e2a7363fad3872e"
      );
    });
  }
  {
    suffix = "19_5_773";
    overriddenVersion = (super: {
      unwrapped = unwrapped (
        getOverrides "19.5.773" "9.3" "cdaceb31659a8a21e315ff9d6fa826fa745eb6cf59435525e77fa45ec6de822a"
      );
    });
  }
]
