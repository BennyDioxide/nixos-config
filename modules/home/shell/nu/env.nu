$env.PATH = ($env.PATH | append (glob $"($nu.home-dir)/{.cargo,.local}/bin"))
