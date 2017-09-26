return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "1.0.2",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 99,
  height = 51,
  tilewidth = 32,
  tileheight = 32,
  nextobjectid = 626,
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
      name = "ground_layer_1",
      x = 0,
      y = 0,
      width = 99,
      height = 51,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      compression = "zlib",
      data = "eJztnNFuwyAMRfsr0d6mrS99769N+fN1D0iRZxsbuOCkRrrSsjSpzeEaQqTebtmitOdLj4C6v/QF0j1AflTP4Cw2kJKFn0X6Ylxf1qRd/wMWMnYEi55cLfmg+zti7D0sNK/vlfOtKnF/gFTuPyMXmheKBaqmr2CBnJ+SRbLgtAsqtbccX4EFl+cMFtYay32O/m81i1Hzxd99jg3JQhrjdKxLY15jUbSKhTcvK4vyeQSLY0w940c6F8EXtdx28rcmpC+SxX8WnwdJ1yeL67DQ5ljOo63zRTQWWq2xsODyQ/jC068t10RhcWwaC84DCBaW9YPHz8kC6wsaC/W0FKtU21ax4GqrFKNlHUXvFZWFpgi+qEnKqeb31fNFsuhjIa1ZR83dV2WhjTvtPVQrC6mmSutZqYbWWKA1Oy8EC8/4afHKKhbovM7Igvvu74HH3P3PysLr39qemRTzBpLEYlZeo1jM0Apf9HqhtKuxWDFfJItk0cvCsj/gqaMSi5nPF5FZSM/d9Lu576fnazFGYeGZn1vm7tF7ID0sqG+kdxwrWVg8oJ3X6vooFrWxQGsUx0LLJ1n4WFjeI1pqVLJIFtb5gluD1Pq6VjN2MAtpjHhZrJovtD6XxknLXvloX3j2ps7CwtqP78SC3jsii5p3LM/F6HWUp3ZGZeHZX4jAwutHTz70ODKLCDXqyiw8no/EwvKsfzYWWo49dZm+A0H4olfafkiJ+Ux7g1ZFZGGJOVkki8gsWkVrJaeR74VGChl7K4seWfLRrkf3NzL2FuXvgcRRdBYbSMnCz+LdfJEtTvsFSzNVFQ=="
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
          id = 1,
          name = "",
          type = "",
          shape = "rectangle",
          x = 544,
          y = 224,
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
          id = 4,
          name = "",
          type = "",
          shape = "rectangle",
          x = 608,
          y = 224,
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
          id = 5,
          name = "",
          type = "",
          shape = "rectangle",
          x = 608,
          y = 256,
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
          id = 6,
          name = "",
          type = "",
          shape = "rectangle",
          x = 576,
          y = 256,
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
          id = 8,
          name = "",
          type = "",
          shape = "rectangle",
          x = 288,
          y = 256,
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
          id = 9,
          name = "",
          type = "",
          shape = "rectangle",
          x = 288,
          y = 288,
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
          id = 10,
          name = "",
          type = "",
          shape = "rectangle",
          x = 256,
          y = 288,
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
          id = 11,
          name = "",
          type = "",
          shape = "rectangle",
          x = 256,
          y = 512,
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
          id = 12,
          name = "",
          type = "",
          shape = "rectangle",
          x = 256,
          y = 544,
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
          id = 13,
          name = "",
          type = "",
          shape = "rectangle",
          x = 416,
          y = 608,
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
          id = 14,
          name = "",
          type = "",
          shape = "rectangle",
          x = 416,
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
          id = 15,
          name = "",
          type = "",
          shape = "rectangle",
          x = 352,
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
          id = 16,
          name = "",
          type = "",
          shape = "rectangle",
          x = 352,
          y = 704,
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
          id = 17,
          name = "",
          type = "",
          shape = "rectangle",
          x = 640,
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
          id = 18,
          name = "",
          type = "",
          shape = "rectangle",
          x = 736,
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
          id = 19,
          name = "",
          type = "",
          shape = "rectangle",
          x = 704,
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
          id = 20,
          name = "",
          type = "",
          shape = "rectangle",
          x = 768,
          y = 704,
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
          id = 21,
          name = "",
          type = "",
          shape = "rectangle",
          x = 768,
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
          id = 23,
          name = "",
          type = "",
          shape = "rectangle",
          x = 864,
          y = 384,
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
          id = 24,
          name = "",
          type = "",
          shape = "rectangle",
          x = 864,
          y = 416,
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
          id = 25,
          name = "",
          type = "",
          shape = "rectangle",
          x = 832,
          y = 416,
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
          id = 26,
          name = "",
          type = "",
          shape = "rectangle",
          x = 928,
          y = 480,
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
          id = 27,
          name = "",
          type = "",
          shape = "rectangle",
          x = 928,
          y = 512,
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
          id = 28,
          name = "",
          type = "",
          shape = "rectangle",
          x = 992,
          y = 448,
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
          id = 29,
          name = "",
          type = "",
          shape = "rectangle",
          x = 928,
          y = 448,
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
          id = 30,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1152,
          y = 1104,
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
          id = 31,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1056,
          y = 1088,
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
          id = 32,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1152,
          y = 1168,
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
          id = 33,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1152,
          y = 1136,
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
          id = 34,
          name = "",
          type = "",
          shape = "rectangle",
          x = 992,
          y = 480,
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
          id = 35,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1056,
          y = 1120,
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
          id = 36,
          name = "",
          type = "",
          shape = "rectangle",
          x = 992,
          y = 512,
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
          id = 37,
          name = "",
          type = "",
          shape = "rectangle",
          x = 960,
          y = 1216,
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
          id = 38,
          name = "",
          type = "",
          shape = "rectangle",
          x = 960,
          y = 1248,
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
          id = 39,
          name = "",
          type = "",
          shape = "rectangle",
          x = 993.33,
          y = 1344,
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
          id = 40,
          name = "",
          type = "",
          shape = "rectangle",
          x = 896,
          y = 1344,
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
          id = 41,
          name = "",
          type = "",
          shape = "rectangle",
          x = 896,
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
          id = 42,
          name = "",
          type = "",
          shape = "rectangle",
          x = 544,
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
          id = 43,
          name = "",
          type = "",
          shape = "rectangle",
          x = 576,
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
          id = 44,
          name = "",
          type = "",
          shape = "rectangle",
          x = 576,
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
          id = 46,
          name = "",
          type = "",
          shape = "rectangle",
          x = 512,
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
          id = 47,
          name = "",
          type = "",
          shape = "rectangle",
          x = 512,
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
          id = 48,
          name = "",
          type = "",
          shape = "rectangle",
          x = 512,
          y = 1216,
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
          id = 49,
          name = "",
          type = "",
          shape = "rectangle",
          x = 544,
          y = 1216,
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
          id = 50,
          name = "",
          type = "",
          shape = "rectangle",
          x = 480,
          y = 1312,
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
          id = 51,
          name = "",
          type = "",
          shape = "rectangle",
          x = 448,
          y = 1312,
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
          id = 52,
          name = "",
          type = "",
          shape = "rectangle",
          x = 448,
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
          id = 53,
          name = "",
          type = "",
          shape = "rectangle",
          x = 448,
          y = 1216,
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
          id = 54,
          name = "",
          type = "",
          shape = "rectangle",
          x = 416,
          y = 1216,
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
          id = 55,
          name = "",
          type = "",
          shape = "rectangle",
          x = 384,
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
          id = 56,
          name = "",
          type = "",
          shape = "rectangle",
          x = 416,
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
          id = 57,
          name = "",
          type = "",
          shape = "rectangle",
          x = 384,
          y = 1024,
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
          id = 58,
          name = "",
          type = "",
          shape = "rectangle",
          x = 320,
          y = 992,
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
          id = 59,
          name = "",
          type = "",
          shape = "rectangle",
          x = 352,
          y = 992,
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
          id = 60,
          name = "",
          type = "",
          shape = "rectangle",
          x = 384,
          y = 992,
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
          id = 65,
          name = "",
          type = "",
          shape = "rectangle",
          x = 480,
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
          id = 66,
          name = "",
          type = "",
          shape = "rectangle",
          x = 224,
          y = 160,
          width = 480,
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
          x = 0,
          y = 32,
          width = 32,
          height = 1568,
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
          x = 480,
          y = 320,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Light"
          }
        },
        {
          id = 69,
          name = "",
          type = "",
          shape = "rectangle",
          x = 384,
          y = 352,
          width = 256,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 72,
          name = "",
          type = "",
          shape = "rectangle",
          x = 384,
          y = 383.33,
          width = 32,
          height = 448.67,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 73,
          name = "",
          type = "",
          shape = "rectangle",
          x = 416,
          y = 800,
          width = 96,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 74,
          name = "",
          type = "",
          shape = "rectangle",
          x = 480,
          y = 704,
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
          x = 543.67,
          y = 640,
          width = 32.33,
          height = 64,
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
          x = 544,
          y = 480,
          width = 32,
          height = 63.33,
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
          x = 575.67,
          y = 480,
          width = 64.33,
          height = 32,
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
          x = 768,
          y = 480,
          width = 64,
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
          x = 800,
          y = 512,
          width = 31.67,
          height = 63.33,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 81,
          name = "",
          type = "",
          shape = "rectangle",
          x = 672,
          y = 577.33,
          width = 62.67,
          height = 62,
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
          x = 800,
          y = 672,
          width = 32,
          height = 32,
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
          x = 736,
          y = 704,
          width = 160,
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
          x = 768.67,
          y = 352,
          width = 63.33,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 89,
          name = "",
          type = "",
          shape = "rectangle",
          x = 800,
          y = 288,
          width = 32,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 90,
          name = "",
          type = "",
          shape = "rectangle",
          x = 832,
          y = 288,
          width = 160,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 91,
          name = "",
          type = "",
          shape = "rectangle",
          x = 960.67,
          y = 320,
          width = 31.33,
          height = 288,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 92,
          name = "",
          type = "",
          shape = "rectangle",
          x = 992,
          y = 576,
          width = 96,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 93,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1056,
          y = 288,
          width = 64,
          height = 32.08,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 94,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1088,
          y = 320,
          width = 32,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 95,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1120,
          y = 352,
          width = 64,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 96,
          name = "",
          type = "",
          shape = "rectangle",
          x = 960,
          y = 704,
          width = 32,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 97,
          name = "",
          type = "",
          shape = "rectangle",
          x = 640,
          y = 800.08,
          width = 320,
          height = 31.92,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 98,
          name = "",
          type = "",
          shape = "rectangle",
          x = 672,
          y = 928,
          width = 192,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 99,
          name = "",
          type = "",
          shape = "rectangle",
          x = 832,
          y = 960,
          width = 32,
          height = 288,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 100,
          name = "",
          type = "",
          shape = "rectangle",
          x = 672,
          y = 960,
          width = 32,
          height = 288,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 101,
          name = "",
          type = "",
          shape = "rectangle",
          x = 704,
          y = 1216,
          width = 128,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 102,
          name = "",
          type = "",
          shape = "rectangle",
          x = 928,
          y = 992,
          width = 64,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 103,
          name = "",
          type = "",
          shape = "rectangle",
          x = 928,
          y = 1024,
          width = 32,
          height = 352,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 104,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1056,
          y = 992,
          width = 64,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 105,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1088,
          y = 1024,
          width = 32,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 107,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1056,
          y = 1120,
          width = 32,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 108,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1056,
          y = 1249,
          width = 31.5,
          height = 127,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 109,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1024,
          y = 1344,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 110,
          name = "",
          type = "",
          shape = "rectangle",
          x = 416,
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
          id = 111,
          name = "",
          type = "",
          shape = "rectangle",
          x = 544,
          y = 960,
          width = 32,
          height = 96,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 112,
          name = "",
          type = "",
          shape = "rectangle",
          x = 416,
          y = 960,
          width = 32,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 113,
          name = "",
          type = "",
          shape = "rectangle",
          x = 320,
          y = 1024,
          width = 224,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 114,
          name = "",
          type = "",
          shape = "rectangle",
          x = 320,
          y = 1055.67,
          width = 32,
          height = 96.33,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 115,
          name = "",
          type = "",
          shape = "rectangle",
          x = 480.33,
          y = 1120.66,
          width = 30.6667,
          height = 126.667,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 116,
          name = "",
          type = "",
          shape = "rectangle",
          x = 320,
          y = 1216,
          width = 160,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 117,
          name = "",
          type = "",
          shape = "rectangle",
          x = 416,
          y = 1248,
          width = 32,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 119,
          name = "",
          type = "",
          shape = "rectangle",
          x = 384,
          y = 1312,
          width = 96,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 120,
          name = "",
          type = "",
          shape = "rectangle",
          x = 991.67,
          y = 160,
          width = 192,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 121,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1184,
          y = 160,
          width = 64,
          height = 544,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 122,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1184,
          y = 928,
          width = 64,
          height = 544,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 123,
          name = "",
          type = "",
          shape = "rectangle",
          x = 992,
          y = 1440,
          width = 192,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 124,
          name = "",
          type = "",
          shape = "rectangle",
          x = 255,
          y = 1440,
          width = 448,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 125,
          name = "",
          type = "",
          shape = "rectangle",
          x = 224,
          y = 960,
          width = 31,
          height = 512,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 129,
          name = "spawn_point_4",
          type = "",
          shape = "rectangle",
          x = 800,
          y = 1536,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "PlayerSpawner"
          }
        },
        {
          id = 131,
          name = "spawn_point_1",
          type = "",
          shape = "rectangle",
          x = 800,
          y = 56,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "PlayerSpawner"
          }
        },
        {
          id = 133,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1184,
          y = 704,
          width = 832,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 141,
          name = "",
          type = "",
          shape = "rectangle",
          x = 448,
          y = 1248,
          width = 31.3333,
          height = 31.3333,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Light"
          }
        },
        {
          id = 147,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1216,
          y = 1472,
          width = 768,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 149,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1216,
          y = 128,
          width = 768,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 221,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1952,
          y = 928,
          width = 64,
          height = 544,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 222,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2016,
          y = 1440,
          width = 192,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 225,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2496,
          y = 1440,
          width = 448,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 226,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2912,
          y = 960,
          width = 32,
          height = 480,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 227,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2912,
          y = 160,
          width = 32,
          height = 512,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 228,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2496,
          y = 160,
          width = 416,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 229,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1952,
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
          id = 231,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1952,
          y = 192,
          width = 64,
          height = 512,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 233,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2112,
          y = 192,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 234,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2144,
          y = 352,
          width = 224,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 235,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2112,
          y = 320,
          width = 32,
          height = 512,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 236,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2144,
          y = 800,
          width = 96,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 237,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2208,
          y = 704,
          width = 128,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 239,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2240,
          y = 480,
          width = 32,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 240,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2272,
          y = 480,
          width = 128,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 242,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2368,
          y = 512,
          width = 32,
          height = 96,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 243,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2272,
          y = 576,
          width = 96,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 244,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2496,
          y = 352,
          width = 32,
          height = 256,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 245,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2464,
          y = 704,
          width = 160,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 246,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2368,
          y = 800,
          width = 320,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 247,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2688,
          y = 704,
          width = 32,
          height = 288,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 250,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2592,
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
          id = 251,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2144,
          y = 960,
          width = 544,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 254,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2432,
          y = 992,
          width = 32,
          height = 96,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 255,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2144,
          y = 992,
          width = 32,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 256,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2176,
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
          id = 257,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2080,
          y = 1120,
          width = 64,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 259,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2080,
          y = 1152,
          width = 32,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 260,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2080,
          y = 1280,
          width = 192,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 263,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2208,
          y = 1312,
          width = 256,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 264,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2272,
          y = 1088,
          width = 96,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 266,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2336,
          y = 1120,
          width = 32,
          height = 96,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 267,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2368,
          y = 1184,
          width = 64,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 268,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2432,
          y = 1184,
          width = 32,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 271,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2624,
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
          id = 272,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2624,
          y = 1248,
          width = 32,
          height = 96,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 273,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2656,
          y = 1312,
          width = 128,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 274,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2656,
          y = 1088,
          width = 192,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 275,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2880,
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
          id = 276,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2880,
          y = 352,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 278,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2848,
          y = 576,
          width = 64,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 279,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2752,
          y = 480,
          width = 32,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 280,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2592,
          y = 576,
          width = 160,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 281,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2688,
          y = 608,
          width = 32,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 282,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2592,
          y = 384,
          width = 32,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 283,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2624,
          y = 384,
          width = 224,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 284,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2688,
          y = 288,
          width = 32,
          height = 96,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 286,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2720,
          y = 288,
          width = 128,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 287,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2816,
          y = 320,
          width = 32,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 288,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1248,
          y = 192,
          width = 704,
          height = 512,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Water"
          }
        },
        {
          id = 303,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1248,
          y = 928,
          width = 704,
          height = 512,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Water"
          }
        },
        {
          id = 385,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2016,
          y = 256,
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
          id = 386,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2048,
          y = 224,
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
          id = 387,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2048,
          y = 256,
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
          id = 388,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2176,
          y = 352,
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
          id = 389,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2368,
          y = 480,
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
          id = 390,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2208,
          y = 352,
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
          id = 391,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2144,
          y = 544,
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
          id = 392,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2880,
          y = 256,
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
          id = 393,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2848,
          y = 224,
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
          id = 394,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2464,
          y = 544,
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
          id = 395,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2144,
          y = 512,
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
          id = 396,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2304,
          y = 416,
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
          id = 397,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2656,
          y = 224,
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
          id = 398,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2560,
          y = 256,
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
          id = 399,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2528.67,
          y = 224.937,
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
          id = 401,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2624,
          y = 384,
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
          id = 403,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2624.67,
          y = 352.94,
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
          id = 404,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2656,
          y = 352,
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
          id = 405,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2592,
          y = 224,
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
          id = 406,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2624,
          y = 224,
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
          id = 408,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2464,
          y = 512,
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
          id = 415,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2880,
          y = 544,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 55,
          visible = true,
          properties = {}
        },
        {
          id = 417,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2848,
          y = 544,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 54,
          visible = true,
          properties = {
            ["is_main_part"] = true,
            ["is_multi_part"] = true,
            ["other_parts_count"] = 3,
            ["other_parts_id_1"] = 415,
            ["other_parts_id_2"] = 419,
            ["other_parts_id_3"] = 420,
            ["type"] = "Barrier"
          }
        },
        {
          id = 419,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2848,
          y = 576,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 59,
          visible = true,
          properties = {}
        },
        {
          id = 420,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2880,
          y = 576,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 60,
          visible = true,
          properties = {}
        },
        {
          id = 422,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2880,
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
          id = 423,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2720,
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
          id = 425,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2752,
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
          id = 426,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2880,
          y = 1088,
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
          id = 427,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2144,
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
          id = 428,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2272,
          y = 1280,
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
          id = 429,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2240,
          y = 1280,
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
          id = 430,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2208,
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
          id = 432,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2176,
          y = 1216,
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
          id = 433,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2272,
          y = 1312,
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
          id = 434,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2048,
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
          id = 435,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2016,
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
          id = 437,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2016,
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
          id = 438,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2048,
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
          id = 440,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2848,
          y = 1248,
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
          id = 441,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2848,
          y = 1216,
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
          id = 442,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2880,
          y = 1248,
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
          id = 443,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2816,
          y = 1216,
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
          id = 445,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2720,
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
          id = 447,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2656,
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
          id = 448,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2688,
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
          id = 449,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2753,
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
          id = 450,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2592,
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
          id = 451,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2624,
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
          id = 456,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2336,
          y = 480,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 137,
          visible = true,
          properties = {
            ["type"] = "barrierExplosive"
          }
        },
        {
          id = 458,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2016,
          y = 640,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 137,
          visible = true,
          properties = {
            ["type"] = "barrierExplosive"
          }
        },
        {
          id = 459,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2144,
          y = 352,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 137,
          visible = true,
          properties = {
            ["type"] = "barrierExplosive"
          }
        },
        {
          id = 460,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2144,
          y = 416,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 137,
          visible = true,
          properties = {
            ["type"] = "barrierExplosive"
          }
        },
        {
          id = 462,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2656,
          y = 800,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 137,
          visible = true,
          properties = {
            ["type"] = "barrierExplosive"
          }
        },
        {
          id = 464,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2016,
          y = 224,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 137,
          visible = true,
          properties = {
            ["type"] = "barrierExplosive"
          }
        },
        {
          id = 465,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2560,
          y = 224,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 137,
          visible = true,
          properties = {
            ["type"] = "barrierExplosive"
          }
        },
        {
          id = 466,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2656,
          y = 383,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 137,
          visible = true,
          properties = {
            ["type"] = "barrierExplosive"
          }
        },
        {
          id = 467,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2880,
          y = 224,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 137,
          visible = true,
          properties = {
            ["type"] = "barrierExplosive"
          }
        },
        {
          id = 468,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2720,
          y = 640,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 137,
          visible = true,
          properties = {
            ["type"] = "barrierExplosive"
          }
        },
        {
          id = 469,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2880,
          y = 1216,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 137,
          visible = true,
          properties = {
            ["type"] = "barrierExplosive"
          }
        },
        {
          id = 470,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2880,
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
          id = 472,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2176,
          y = 1184,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 137,
          visible = true,
          properties = {
            ["type"] = "barrierExplosive"
          }
        },
        {
          id = 473,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2016,
          y = 1408,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 137,
          visible = true,
          properties = {
            ["type"] = "barrierExplosive"
          }
        },
        {
          id = 474,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2656,
          y = 1440,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 137,
          visible = true,
          properties = {
            ["type"] = "barrierExplosive"
          }
        },
        {
          id = 475,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2688,
          y = 1440,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 137,
          visible = true,
          properties = {
            ["type"] = "barrierExplosive"
          }
        },
        {
          id = 476,
          name = "",
          type = "",
          shape = "rectangle",
          x = 832,
          y = 352,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 137,
          visible = true,
          properties = {
            ["type"] = "barrierExplosive"
          }
        },
        {
          id = 477,
          name = "",
          type = "",
          shape = "rectangle",
          x = 832,
          y = 384,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 137,
          visible = true,
          properties = {
            ["type"] = "barrierExplosive"
          }
        },
        {
          id = 478,
          name = "",
          type = "",
          shape = "rectangle",
          x = 256,
          y = 256,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 137,
          visible = true,
          properties = {
            ["type"] = "barrierExplosive"
          }
        },
        {
          id = 479,
          name = "",
          type = "",
          shape = "rectangle",
          x = 576,
          y = 224,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 137,
          visible = true,
          properties = {
            ["type"] = "barrierExplosive"
          }
        },
        {
          id = 480,
          name = "",
          type = "",
          shape = "rectangle",
          x = 544,
          y = 1440,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 137,
          visible = true,
          properties = {
            ["type"] = "barrierExplosive"
          }
        },
        {
          id = 481,
          name = "",
          type = "",
          shape = "rectangle",
          x = 512,
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
          id = 482,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2496,
          y = 1024,
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
          id = 483,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2464,
          y = 1088,
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
          id = 484,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2880,
          y = 1024,
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
          id = 485,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2528,
          y = 1024,
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
          id = 486,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2880,
          y = 1056,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 137,
          visible = true,
          properties = {
            ["type"] = "barrierExplosive"
          }
        },
        {
          id = 487,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2464,
          y = 1024,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 137,
          visible = true,
          properties = {
            ["type"] = "barrierExplosive"
          }
        },
        {
          id = 488,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2464,
          y = 1056,
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
          id = 489,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2721,
          y = 960,
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
          id = 490,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2080,
          y = 416,
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
          id = 491,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2080,
          y = 352,
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
          id = 492,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2080,
          y = 384,
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
          id = 508,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1184,
          y = 864,
          width = 832,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 509,
          name = "",
          type = "",
          shape = "rectangle",
          x = -1,
          y = 0,
          width = 3168,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 510,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 1600,
          width = 3168,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 511,
          name = "",
          type = "",
          shape = "rectangle",
          x = 224,
          y = 192,
          width = 32,
          height = 480,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 512,
          name = "",
          type = "",
          shape = "rectangle",
          x = 3134,
          y = 32,
          width = 32,
          height = 1568,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 513,
          name = "spawn_point_6",
          type = "",
          shape = "rectangle",
          x = 63,
          y = 1151,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "PlayerSpawner"
          }
        },
        {
          id = 514,
          name = "spawn_point_2",
          type = "",
          shape = "rectangle",
          x = 1056,
          y = 800,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "PlayerSpawner"
          }
        },
        {
          id = 515,
          name = "spawn_point_3",
          type = "",
          shape = "rectangle",
          x = 64,
          y = 768,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "PlayerSpawner"
          }
        },
        {
          id = 516,
          name = "spawn_point_5",
          type = "",
          shape = "rectangle",
          x = 64,
          y = 416,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "PlayerSpawner"
          }
        },
        {
          id = 517,
          name = "spawn_point_7",
          type = "",
          shape = "rectangle",
          x = 64,
          y = 128,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "PlayerSpawner"
          }
        },
        {
          id = 518,
          name = "spawn_point_8",
          type = "",
          shape = "rectangle",
          x = 64,
          y = 1504,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "PlayerSpawner"
          }
        },
        {
          id = 519,
          name = "spawn_point_13",
          type = "",
          shape = "rectangle",
          x = 3072,
          y = 1176,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "PlayerSpawner"
          }
        },
        {
          id = 520,
          name = "spawn_point_9",
          type = "",
          shape = "rectangle",
          x = 2080,
          y = 800,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "PlayerSpawner"
          }
        },
        {
          id = 521,
          name = "spawn_point_15",
          type = "",
          shape = "rectangle",
          x = 3069,
          y = 97,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "PlayerSpawner"
          }
        },
        {
          id = 522,
          name = "spawn_point_16",
          type = "",
          shape = "rectangle",
          x = 3066,
          y = 1504,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "PlayerSpawner"
          }
        },
        {
          id = 523,
          name = "spawn_point_12",
          type = "",
          shape = "rectangle",
          x = 3067,
          y = 800,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "PlayerSpawner"
          }
        },
        {
          id = 524,
          name = "spawn_point_14",
          type = "",
          shape = "rectangle",
          x = 3071,
          y = 411,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "PlayerSpawner"
          }
        },
        {
          id = 525,
          name = "spawn_point_11",
          type = "",
          shape = "rectangle",
          x = 2368,
          y = 64,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "PlayerSpawner"
          }
        },
        {
          id = 526,
          name = "spawn_point_10",
          type = "",
          shape = "rectangle",
          x = 2397,
          y = 1536,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "PlayerSpawner"
          }
        },
        {
          id = 527,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2080,
          y = 1024,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 137,
          visible = true,
          properties = {
            ["type"] = "barrierExplosive"
          }
        },
        {
          id = 528,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2080,
          y = 1056,
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
          id = 529,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2112,
          y = 1056,
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
          id = 530,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2112,
          y = 1024,
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
          id = 532,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2335.33,
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
          id = 533,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2144,
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
          id = 534,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2271.33,
          y = 640,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 137,
          visible = true,
          properties = {
            ["type"] = "barrierExplosive"
          }
        },
        {
          id = 535,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2303.33,
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
          id = 537,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2560,
          y = 960,
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
          id = 538,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2528,
          y = 928,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 137,
          visible = true,
          properties = {
            ["type"] = "barrierExplosive"
          }
        },
        {
          id = 539,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2560,
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
          id = 540,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2528,
          y = 960,
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
          id = 541,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2560,
          y = 160,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 137,
          visible = true,
          properties = {
            ["type"] = "barrierExplosive"
          }
        },
        {
          id = 542,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2144,
          y = 160,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 137,
          visible = true,
          properties = {
            ["type"] = "barrierExplosive"
          }
        },
        {
          id = 543,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2592,
          y = 1504,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 137,
          visible = true,
          properties = {
            ["type"] = "barrierExplosive"
          }
        },
        {
          id = 550,
          name = "",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 544,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 137,
          visible = true,
          properties = {
            ["type"] = "barrierExplosive"
          }
        },
        {
          id = 551,
          name = "",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 704,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 137,
          visible = true,
          properties = {
            ["type"] = "barrierExplosive"
          }
        },
        {
          id = 552,
          name = "",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 960,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 137,
          visible = true,
          properties = {
            ["type"] = "barrierExplosive"
          }
        },
        {
          id = 553,
          name = "",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 1120,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 137,
          visible = true,
          properties = {
            ["type"] = "barrierExplosive"
          }
        },
        {
          id = 554,
          name = "",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 160,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 137,
          visible = true,
          properties = {
            ["type"] = "barrierExplosive"
          }
        },
        {
          id = 555,
          name = "",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 320,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 137,
          visible = true,
          properties = {
            ["type"] = "barrierExplosive"
          }
        },
        {
          id = 556,
          name = "",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 1344,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 137,
          visible = true,
          properties = {
            ["type"] = "barrierExplosive"
          }
        },
        {
          id = 557,
          name = "",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 1504,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 137,
          visible = true,
          properties = {
            ["type"] = "barrierExplosive"
          }
        },
        {
          id = 558,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2976,
          y = 544,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 137,
          visible = true,
          properties = {
            ["type"] = "barrierExplosive"
          }
        },
        {
          id = 559,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2976,
          y = 960,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 137,
          visible = true,
          properties = {
            ["type"] = "barrierExplosive"
          }
        },
        {
          id = 560,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2976,
          y = 1504,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 137,
          visible = true,
          properties = {
            ["type"] = "barrierExplosive"
          }
        },
        {
          id = 561,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2976,
          y = 1120,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 137,
          visible = true,
          properties = {
            ["type"] = "barrierExplosive"
          }
        },
        {
          id = 562,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2976,
          y = 704,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 137,
          visible = true,
          properties = {
            ["type"] = "barrierExplosive"
          }
        },
        {
          id = 563,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2976,
          y = 1344,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 137,
          visible = true,
          properties = {
            ["type"] = "barrierExplosive"
          }
        },
        {
          id = 564,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2976,
          y = 320,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 137,
          visible = true,
          properties = {
            ["type"] = "barrierExplosive"
          }
        },
        {
          id = 565,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2976,
          y = 160,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 137,
          visible = true,
          properties = {
            ["type"] = "barrierExplosive"
          }
        },
        {
          id = 566,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2144,
          y = 1504,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 137,
          visible = true,
          properties = {
            ["type"] = "barrierExplosive"
          }
        },
        {
          id = 567,
          name = "",
          type = "",
          shape = "rectangle",
          x = 640,
          y = 160,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 137,
          visible = true,
          properties = {
            ["type"] = "barrierExplosive"
          }
        },
        {
          id = 568,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1056,
          y = 160,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 137,
          visible = true,
          properties = {
            ["type"] = "barrierExplosive"
          }
        },
        {
          id = 569,
          name = "",
          type = "",
          shape = "rectangle",
          x = 640,
          y = 1504,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 137,
          visible = true,
          properties = {
            ["type"] = "barrierExplosive"
          }
        },
        {
          id = 570,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1056,
          y = 1504,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 137,
          visible = true,
          properties = {
            ["type"] = "barrierExplosive"
          }
        },
        {
          id = 571,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2720,
          y = 864,
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
          id = 572,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2720,
          y = 896,
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
          id = 573,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2720,
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
          id = 574,
          name = "",
          type = "",
          shape = "rectangle",
          x = 60,
          y = 1056,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "ItemSpawner"
          }
        },
        {
          id = 575,
          name = "",
          type = "",
          shape = "rectangle",
          x = 64,
          y = 544,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "ItemSpawner"
          }
        },
        {
          id = 576,
          name = "",
          type = "",
          shape = "rectangle",
          x = 3040,
          y = 544,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "ItemSpawner"
          }
        },
        {
          id = 577,
          name = "",
          type = "",
          shape = "rectangle",
          x = 3040,
          y = 1056,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "ItemSpawner"
          }
        },
        {
          id = 578,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2524,
          y = 1216,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "ItemSpawner"
          }
        },
        {
          id = 580,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2784,
          y = 960,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "ItemSpawner"
          }
        },
        {
          id = 581,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2016,
          y = 382,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "ItemSpawner"
          }
        },
        {
          id = 583,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1568,
          y = 800,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "ItemSpawner"
          }
        },
        {
          id = 584,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2440,
          y = 408,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "ItemSpawner"
          }
        },
        {
          id = 585,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2179,
          y = 928,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "ItemSpawner"
          }
        },
        {
          id = 586,
          name = "",
          type = "",
          shape = "rectangle",
          x = 872,
          y = 928,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "ItemSpawner"
          }
        },
        {
          id = 587,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1120,
          y = 1248,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "ItemSpawner"
          }
        },
        {
          id = 588,
          name = "",
          type = "",
          shape = "rectangle",
          x = 344,
          y = 416,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "ItemSpawner"
          }
        },
        {
          id = 589,
          name = "",
          type = "",
          shape = "rectangle",
          x = 352,
          y = 219,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "ItemSpawner"
          }
        },
        {
          id = 590,
          name = "",
          type = "",
          shape = "rectangle",
          x = 768,
          y = 442,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "ItemSpawner"
          }
        },
        {
          id = 591,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2112,
          y = 1504,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 151,
          visible = true,
          properties = {
            ["type"] = "barrier"
          }
        },
        {
          id = 594,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2112,
          y = 1536,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 151,
          visible = true,
          properties = {
            ["type"] = "barrier"
          }
        },
        {
          id = 595,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2144,
          y = 1536,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 151,
          visible = true,
          properties = {
            ["type"] = "barrier"
          }
        },
        {
          id = 601,
          name = "",
          type = "",
          shape = "rectangle",
          x = 256,
          y = 672,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 48,
          visible = true,
          properties = {
            ["type"] = "light"
          }
        },
        {
          id = 607,
          name = "",
          type = "",
          shape = "rectangle",
          x = 672,
          y = 224,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 48,
          visible = true,
          properties = {
            ["type"] = "light"
          }
        },
        {
          id = 608,
          name = "",
          type = "",
          shape = "rectangle",
          x = 992,
          y = 224,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 48,
          visible = true,
          properties = {
            ["type"] = "light"
          }
        },
        {
          id = 610,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1152,
          y = 768,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 48,
          visible = true,
          properties = {
            ["type"] = "light"
          }
        },
        {
          id = 613,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1152,
          y = 896,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 48,
          visible = true,
          properties = {
            ["type"] = "light"
          }
        },
        {
          id = 615,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2016,
          y = 768,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 48,
          visible = true,
          properties = {
            ["type"] = "light"
          }
        },
        {
          id = 616,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2016,
          y = 896,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 48,
          visible = true,
          properties = {
            ["type"] = "light"
          }
        },
        {
          id = 617,
          name = "",
          type = "",
          shape = "rectangle",
          x = 672,
          y = 1440,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 48,
          visible = true,
          properties = {
            ["type"] = "light"
          }
        },
        {
          id = 618,
          name = "",
          type = "",
          shape = "rectangle",
          x = 992,
          y = 1440,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 48,
          visible = true,
          properties = {
            ["type"] = "light"
          }
        },
        {
          id = 619,
          name = "",
          type = "",
          shape = "rectangle",
          x = 256,
          y = 992,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 48,
          visible = true,
          properties = {
            ["type"] = "light"
          }
        },
        {
          id = 620,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2176,
          y = 1440,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 48,
          visible = true,
          properties = {
            ["type"] = "light"
          }
        },
        {
          id = 621,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2496,
          y = 1440,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 48,
          visible = true,
          properties = {
            ["type"] = "light"
          }
        },
        {
          id = 622,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2880,
          y = 672,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 48,
          visible = true,
          properties = {
            ["type"] = "light"
          }
        },
        {
          id = 623,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2880,
          y = 992,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 48,
          visible = true,
          properties = {
            ["type"] = "light"
          }
        },
        {
          id = 624,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2176,
          y = 224,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 48,
          visible = true,
          properties = {
            ["type"] = "light"
          }
        },
        {
          id = 625,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2496,
          y = 224,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 48,
          visible = true,
          properties = {
            ["type"] = "light"
          }
        }
      }
    }
  }
}
