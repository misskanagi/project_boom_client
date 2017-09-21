return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "1.0.2",
  orientation = "orthogonal",
  renderorder = "left-down",
  width = 47,
  height = 61,
  tilewidth = 32,
  tileheight = 32,
  nextobjectid = 201,
  backgroundcolor = { 150, 150, 150 },
  properties = {},
  tilesets = {
    {
      name = "cs2dnorm",
      firstgid = 1,
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      image = "cs2dnorm.bmp",
      imagewidth = 544,
      imageheight = 480,
      transparentcolor = "#ff00ff",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 32,
        height = 32
      },
      properties = {},
      terrains = {},
      tilecount = 255,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "gound_layer_1",
      x = 0,
      y = 0,
      width = 47,
      height = 61,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      compression = "zlib",
      data = "eJztl0ESwyAIRZP7dLLp3Xr+duM0tQUEgaj9zPxNVHzjfIju27yxv/RIVAT7jZE0XubcBYFdx96iY0H2yHqI9ozmXP6RvajO9UvHSefv2eyFfyPYz5xSLbaw1+fQy14ii53bD+zfHub8bmWnakfbN1vYNT1Ge+499Vvnqn1yEPk5P9VrwL42+8x+z+gzWezR/R3s73Wauxillpxcfgv7CAL7XOwt3vTwt7Teyq6N3hxgX5vd2v+z2CVZ/rMZ7JIsb1iwr81u9Ts3nskuzafYd2J8Bnbu3Ee4E1h6JPVej7iLzcSu/QeOwq4Nid1y//W4U3mxW3KCXd4H7J85wS7vE9Fnet4uXuwRAvva7Fa/j8I+Qk5qH0mWnBnsXnGFZ7xCU/Ng9wuwXxPa/o+4Np49xqCT"
    },
    {
      type = "objectgroup",
      name = "entity_layer_1",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 3,
          name = "",
          type = "",
          shape = "rectangle",
          x = 32,
          y = 32,
          width = 32,
          height = 256,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 5,
          name = "",
          type = "",
          shape = "rectangle",
          x = 64,
          y = 256,
          width = 64,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 6,
          name = "",
          type = "",
          shape = "rectangle",
          x = 64,
          y = 32,
          width = 832,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 7,
          name = "",
          type = "",
          shape = "rectangle",
          x = 288,
          y = 64,
          width = 32,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 8,
          name = "",
          type = "",
          shape = "rectangle",
          x = 576,
          y = 64,
          width = 32,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 9,
          name = "",
          type = "",
          shape = "rectangle",
          x = 864,
          y = 64,
          width = 32,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 10,
          name = "",
          type = "",
          shape = "rectangle",
          x = 896,
          y = 160,
          width = 256,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 11,
          name = "",
          type = "",
          shape = "rectangle",
          x = 768,
          y = 160,
          width = 96,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 12,
          name = "",
          type = "",
          shape = "rectangle",
          x = 768,
          y = 192,
          width = 32,
          height = 256,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 13,
          name = "",
          type = "",
          shape = "rectangle",
          x = 576,
          y = 192,
          width = 32,
          height = 96,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 14,
          name = "",
          type = "",
          shape = "rectangle",
          x = 512,
          y = 256,
          width = 64,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 15,
          name = "",
          type = "",
          shape = "rectangle",
          x = 288,
          y = 192,
          width = 32,
          height = 96,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 16,
          name = "",
          type = "",
          shape = "rectangle",
          x = 320,
          y = 256,
          width = 96,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 17,
          name = "",
          type = "",
          shape = "rectangle",
          x = 224,
          y = 256,
          width = 64,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 18,
          name = "",
          type = "",
          shape = "rectangle",
          x = 224,
          y = 288,
          width = 32,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 19,
          name = "",
          type = "",
          shape = "rectangle",
          x = 96,
          y = 288,
          width = 32,
          height = 992,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 20,
          name = "",
          type = "",
          shape = "rectangle",
          x = 224,
          y = 544,
          width = 32,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 21,
          name = "",
          type = "",
          shape = "rectangle",
          x = 352,
          y = 384,
          width = 32,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 22,
          name = "",
          type = "",
          shape = "rectangle",
          x = 384,
          y = 384,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 23,
          name = "",
          type = "",
          shape = "rectangle",
          x = 512,
          y = 384,
          width = 64,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 24,
          name = "",
          type = "",
          shape = "rectangle",
          x = 544,
          y = 416,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 25,
          name = "",
          type = "",
          shape = "rectangle",
          x = 544,
          y = 544,
          width = 32,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 26,
          name = "",
          type = "",
          shape = "rectangle",
          x = 512,
          y = 576,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 27,
          name = "",
          type = "",
          shape = "rectangle",
          x = 352,
          y = 544,
          width = 32,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 28,
          name = "",
          type = "",
          shape = "rectangle",
          x = 384,
          y = 576,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 29,
          name = "",
          type = "",
          shape = "rectangle",
          x = 256,
          y = 672,
          width = 160,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 30,
          name = "",
          type = "",
          shape = "rectangle",
          x = 512,
          y = 672,
          width = 288,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 31,
          name = "",
          type = "",
          shape = "rectangle",
          x = 768,
          y = 544,
          width = 32,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 32,
          name = "",
          type = "",
          shape = "rectangle",
          x = 896,
          y = 288,
          width = 32,
          height = 416,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 33,
          name = "",
          type = "",
          shape = "rectangle",
          x = 928,
          y = 672,
          width = 256,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 34,
          name = "",
          type = "",
          shape = "rectangle",
          x = 928,
          y = 288,
          width = 96,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 35,
          name = "",
          type = "",
          shape = "rectangle",
          x = 992,
          y = 320,
          width = 32,
          height = 352,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 36,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1120,
          y = 192,
          width = 32,
          height = 224,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 37,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1152,
          y = 384,
          width = 160,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 38,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1280,
          y = 416,
          width = 32,
          height = 1088,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 39,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1312,
          y = 1472,
          width = 128,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 42,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1152,
          y = 800,
          width = 32,
          height = 384,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 43,
          name = "",
          type = "",
          shape = "rectangle",
          x = 768,
          y = 800,
          width = 384,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 44,
          name = "",
          type = "",
          shape = "rectangle",
          x = 768,
          y = 832,
          width = 32,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 45,
          name = "",
          type = "",
          shape = "rectangle",
          x = 800,
          y = 928,
          width = 128,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 46,
          name = "",
          type = "",
          shape = "rectangle",
          x = 896,
          y = 960,
          width = 32,
          height = 224,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 48,
          name = "",
          type = "",
          shape = "rectangle",
          x = 928,
          y = 1152,
          width = 224,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 51,
          name = "",
          type = "",
          shape = "rectangle",
          x = 736,
          y = 1280,
          width = 448,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 52,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1152,
          y = 1312,
          width = 32,
          height = 192,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 53,
          name = "",
          type = "",
          shape = "rectangle",
          x = 736,
          y = 1312,
          width = 32,
          height = 192,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 54,
          name = "",
          type = "",
          shape = "rectangle",
          x = 768,
          y = 1472,
          width = 384,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 55,
          name = "",
          type = "",
          shape = "rectangle",
          x = 672,
          y = 1088,
          width = 32,
          height = 96,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 56,
          name = "",
          type = "",
          shape = "rectangle",
          x = 736,
          y = 1088,
          width = 32,
          height = 96,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 57,
          name = "",
          type = "",
          shape = "rectangle",
          x = 704,
          y = 1088,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 58,
          name = "",
          type = "",
          shape = "rectangle",
          x = 704,
          y = 1152,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 64,
          name = "",
          type = "",
          shape = "rectangle",
          x = 480,
          y = 928,
          width = 32,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 65,
          name = "",
          type = "",
          shape = "rectangle",
          x = 512,
          y = 928,
          width = 160,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 66,
          name = "",
          type = "",
          shape = "rectangle",
          x = 224,
          y = 800,
          width = 448,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 67,
          name = "",
          type = "",
          shape = "rectangle",
          x = 640,
          y = 832,
          width = 32,
          height = 96,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 68,
          name = "",
          type = "",
          shape = "rectangle",
          x = 224,
          y = 832,
          width = 32,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 69,
          name = "",
          type = "",
          shape = "rectangle",
          x = 256,
          y = 960,
          width = 224,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 71,
          name = "",
          type = "",
          shape = "rectangle",
          x = 128,
          y = 1248,
          width = 128,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 76,
          name = "",
          type = "",
          shape = "rectangle",
          x = 224,
          y = 1088,
          width = 32,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 77,
          name = "",
          type = "",
          shape = "rectangle",
          x = 256,
          y = 1088,
          width = 256,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 78,
          name = "",
          type = "",
          shape = "rectangle",
          x = 480,
          y = 1120,
          width = 32,
          height = 576,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 79,
          name = "",
          type = "",
          shape = "rectangle",
          x = 512,
          y = 1664,
          width = 256,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 80,
          name = "",
          type = "",
          shape = "rectangle",
          x = 736,
          y = 1600,
          width = 32,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 82,
          name = "",
          type = "",
          shape = "rectangle",
          x = 768,
          y = 1600,
          width = 416,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 83,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1152,
          y = 1632,
          width = 32,
          height = 96,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 84,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1088,
          y = 1696,
          width = 64,
          height = 96,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 85,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1056,
          y = 1696,
          width = 32,
          height = 192,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 86,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1088,
          y = 1856,
          width = 352,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 88,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1408,
          y = 1504,
          width = 32,
          height = 352,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 123,
          name = "spawn_point_1",
          type = "",
          shape = "rectangle",
          x = 1280,
          y = 1664,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Player"
          }
        },
        {
          id = 127,
          name = "",
          type = "",
          shape = "rectangle",
          x = 448,
          y = 480,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Light"
          }
        },
        {
          id = 133,
          name = "",
          type = "",
          shape = "rectangle",
          x = 800,
          y = 192,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Light"
          }
        },
        {
          id = 136,
          name = "",
          type = "",
          shape = "rectangle",
          x = 256,
          y = 64,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Light"
          }
        },
        {
          id = 139,
          name = "",
          type = "",
          shape = "rectangle",
          x = 512,
          y = 960,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Light"
          }
        },
        {
          id = 140,
          name = "",
          type = "",
          shape = "rectangle",
          x = 864,
          y = 960,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Light"
          }
        },
        {
          id = 141,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1248,
          y = 1760,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Light"
          }
        },
        {
          id = 151,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1312,
          y = 1632,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 60,
          visible = true,
          properties = {}
        },
        {
          id = 155,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1280,
          y = 1600,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 54,
          visible = true,
          properties = {
            ["is_main_part"] = true,
            ["is_multi_part"] = true,
            ["other_parts_count"] = 3,
            ["other_parts_id_1"] = 156,
            ["other_parts_id_2"] = 157,
            ["other_parts_id_3"] = 151,
            ["type"] = "Barrier"
          }
        },
        {
          id = 156,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1312,
          y = 1600,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 55,
          visible = true,
          properties = {}
        },
        {
          id = 157,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1280,
          y = 1632,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 59,
          visible = true,
          properties = {}
        },
        {
          id = 164,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1184,
          y = 1568,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 150,
          visible = true,
          properties = {
            ["type"] = "barrier"
          }
        },
        {
          id = 166,
          name = "spawn_point_2",
          type = "",
          shape = "rectangle",
          x = 154.561,
          y = 151.875,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Player"
          }
        },
        {
          id = 167,
          name = "",
          type = "",
          shape = "rectangle",
          x = 704,
          y = 1376,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 150,
          visible = true,
          properties = {
            ["type"] = "barrier"
          }
        },
        {
          id = 168,
          name = "",
          type = "",
          shape = "rectangle",
          x = 682.099,
          y = 995.407,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 150,
          visible = true,
          properties = {
            ["type"] = "barrier"
          }
        },
        {
          id = 169,
          name = "",
          type = "",
          shape = "rectangle",
          x = 674.494,
          y = 491.985,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 150,
          visible = true,
          properties = {
            ["type"] = "barrier"
          }
        },
        {
          id = 170,
          name = "",
          type = "",
          shape = "rectangle",
          x = 512,
          y = 96,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 150,
          visible = true,
          properties = {
            ["type"] = "barrier"
          }
        },
        {
          id = 171,
          name = "",
          type = "",
          shape = "rectangle",
          x = 192,
          y = 1248,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 60,
          visible = true,
          properties = {}
        },
        {
          id = 172,
          name = "",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 1248,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 59,
          visible = true,
          properties = {}
        },
        {
          id = 173,
          name = "",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 1216,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 54,
          visible = true,
          properties = {
            ["is_main_part"] = true,
            ["is_multi_part"] = true,
            ["other_parts_count"] = 3,
            ["other_parts_id_1"] = 171,
            ["other_parts_id_2"] = 174,
            ["other_parts_id_3"] = 172,
            ["type"] = "Barrier"
          }
        },
        {
          id = 174,
          name = "",
          type = "",
          shape = "rectangle",
          x = 192,
          y = 1216,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 55,
          visible = true,
          properties = {}
        },
        {
          id = 175,
          name = "",
          type = "",
          shape = "rectangle",
          x = 128,
          y = 672,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 150,
          visible = true,
          properties = {
            ["type"] = "barrier"
          }
        },
        {
          id = 176,
          name = "",
          type = "",
          shape = "rectangle",
          x = 128,
          y = 640,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 150,
          visible = true,
          properties = {
            ["type"] = "barrier"
          }
        },
        {
          id = 177,
          name = "",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 640,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 150,
          visible = true,
          properties = {
            ["type"] = "barrier"
          }
        },
        {
          id = 178,
          name = "",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 672,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 150,
          visible = true,
          properties = {
            ["type"] = "barrier"
          }
        },
        {
          id = 179,
          name = "",
          type = "",
          shape = "rectangle",
          x = 192,
          y = 1184,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 150,
          visible = true,
          properties = {
            ["type"] = "barrier"
          }
        },
        {
          id = 180,
          name = "",
          type = "",
          shape = "rectangle",
          x = 128,
          y = 1152,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 150,
          visible = true,
          properties = {
            ["type"] = "barrier"
          }
        },
        {
          id = 181,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1024,
          y = 672,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 150,
          visible = true,
          properties = {
            ["type"] = "barrier"
          }
        },
        {
          id = 182,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1056,
          y = 672,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 150,
          visible = true,
          properties = {
            ["type"] = "barrier"
          }
        },
        {
          id = 183,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1024,
          y = 640,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 150,
          visible = true,
          properties = {
            ["type"] = "barrier"
          }
        },
        {
          id = 184,
          name = "",
          type = "",
          shape = "rectangle",
          x = 864,
          y = 576,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 150,
          visible = true,
          properties = {
            ["type"] = "barrier"
          }
        },
        {
          id = 185,
          name = "",
          type = "",
          shape = "rectangle",
          x = 672,
          y = 1376,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 150,
          visible = true,
          properties = {
            ["type"] = "barrier"
          }
        },
        {
          id = 186,
          name = "",
          type = "",
          shape = "rectangle",
          x = 640,
          y = 1376,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 150,
          visible = true,
          properties = {
            ["type"] = "barrier"
          }
        },
        {
          id = 187,
          name = "",
          type = "",
          shape = "rectangle",
          x = 704,
          y = 1440,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 150,
          visible = true,
          properties = {
            ["type"] = "barrier"
          }
        },
        {
          id = 188,
          name = "",
          type = "",
          shape = "rectangle",
          x = 672,
          y = 1408,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 150,
          visible = true,
          properties = {
            ["type"] = "barrier"
          }
        },
        {
          id = 189,
          name = "",
          type = "",
          shape = "rectangle",
          x = 704,
          y = 1408,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 150,
          visible = true,
          properties = {
            ["type"] = "barrier"
          }
        },
        {
          id = 190,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1248,
          y = 1152,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 150,
          visible = true,
          properties = {
            ["type"] = "barrier"
          }
        },
        {
          id = 191,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1184,
          y = 928,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 150,
          visible = true,
          properties = {
            ["type"] = "barrier"
          }
        },
        {
          id = 192,
          name = "",
          type = "",
          shape = "rectangle",
          x = 992,
          y = 800,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 150,
          visible = true,
          properties = {
            ["type"] = "barrier"
          }
        },
        {
          id = 193,
          name = "",
          type = "",
          shape = "rectangle",
          x = 416,
          y = 800,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 150,
          visible = true,
          properties = {
            ["type"] = "barrier"
          }
        },
        {
          id = 194,
          name = "",
          type = "",
          shape = "rectangle",
          x = 320,
          y = 224,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 54,
          visible = true,
          properties = {
            ["is_main_part"] = true,
            ["is_multi_part"] = true,
            ["other_parts_count"] = 3,
            ["other_parts_id_1"] = 195,
            ["other_parts_id_2"] = 196,
            ["other_parts_id_3"] = 197,
            ["type"] = "Barrier"
          }
        },
        {
          id = 195,
          name = "",
          type = "",
          shape = "rectangle",
          x = 320,
          y = 256,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 59,
          visible = true,
          properties = {}
        },
        {
          id = 196,
          name = "",
          type = "",
          shape = "rectangle",
          x = 352,
          y = 256,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 60,
          visible = true,
          properties = {}
        },
        {
          id = 197,
          name = "",
          type = "",
          shape = "rectangle",
          x = 352,
          y = 224,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 55,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
