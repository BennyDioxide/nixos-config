$env.PATH = ($env.PATH | append (glob $"($nu.home-path)/{.cargo,.local}/bin"))
