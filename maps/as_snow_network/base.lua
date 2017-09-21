return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "1.0.2",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 154,
  height = 100,
  tilewidth = 32,
  tileheight = 32,
  nextobjectid = 202,
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
      width = 154,
      height = 100,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      compression = "zlib",
      data = "eJztnd1q3DAQRvcR8g65aUvZvcjzleI3L4EajNBoZvQzkrXHcGA32Rjr09mRLBny+Xg8PgEAAAAAAAAAAMDFT4AKajx7ATjAM4gAzyACPIMI8AwiqPXsm2dCr/sSyzXDuplKXsxeJ0k52/4hvJ59fXeETMmETMlkF8iUTMiUTHaBTMmETMlkF94h09b1l1HrdBZWyaT3mlZLprN9KmX6dUNGeza7fatlQqZkgmf3zJRMyBTP8GyXTMlkn0y1e6znxEy1TFqvHc98/G3A0lfaOUZlEnHtEniW9+x3gUP5fS1RnkW0JW0Xnvk9ew7sj2jPRrUFz/AMz/by7BA45zrn+x08y7UTz2LmZ7nPpT+b7Vmv+dn3ea4HntV5JtWmtEZJtark2cksz7ztsnp2fh7PfJ5d82753ku/W6GeaW07ktclqGd41suzXxekv8czPMOz9TzL/ax1fraaZ6Xxz+JZrn141u6Zt3bdwbPrUfIsV7vwzOeZ5T7LM8bgGZ7V1rM053SckfpBGm9neZYb76VrtNxvpufCs3jPSqxQzzSkNml1Gs/Gzc/wDM8kpHWLXvcBFs/+KEjPhml/N9Kz0neq9RnJ0Z79EJjlmTSHkdY0pDmL1h+efvc6khvro9oV5ZnXm9U869HXK3oW1S48wzM8W8cz75ii7S+v4llUu/BM9yyCGZ611rDzwDM8wzO7N17w7H09i2SEZ5Y9Gc+8JWXG+hmezfHsq9AXlj3m9KjxbFQmkmeeuX7NfQD7ATGepfUufb+CZ5bapY3JeFbvmfYdTsfN9Dge5b7CMzw787U8m2wZN/EMz97dM2mfU/NIq/XHA89qPZO+217PZs3PSj5J34Ga54GoZ3bPPHudd/HM6gie7eFZeu4VPdNqnmXdF89s46Z1rUj77GqeefYG8GysZ94xwtNX6fuVPWPcxLNazzy1Gs9iPLPsr9zNs1IbW+YK6b4rnvnqWSulPaizP2Z6Ngo8i/XM0h94hmd4hme9PatFejYsNz5KjPZs5LVL4FlfLH01K1P+H8o+nq2cKZmQKZ7h2S6ZkgmZ4hme7ZIpmYzJ1IN2n+U9XwurZNJKz0xn+9SL138+hNezr++OkCmZkCmZ7AKZkgmZkskukCmZkCmZ7MIdM5XWZHqt9bwUoteediAyU8mLGs+06wa4gmcQAZ5BBHgGEeAZRFDrGYCX2eskAAAAAAAAAAAAAJDnHyU+W/8="
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
          x = 1376,
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
          id = 3,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1408,
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
          id = 4,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1440,
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
          id = 5,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1440,
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
          id = 6,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1408,
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
          id = 7,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1088,
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
          id = 8,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1120,
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
          id = 9,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1120,
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
          id = 10,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1088,
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
          id = 11,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1088,
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
          id = 12,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1088,
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
          id = 13,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1250.67,
          y = 1364,
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
          x = 1252,
          y = 1396,
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
          x = 1184,
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
          id = 16,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1184,
          y = 1472,
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
          x = 1438.67,
          y = 1398.67,
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
          x = 1568,
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
          id = 19,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1536,
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
          id = 20,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1600,
          y = 1472,
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
          x = 1600,
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
          id = 22,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1664,
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
          id = 23,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1696,
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
          id = 24,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1696,
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
          id = 25,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1664,
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
          id = 26,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1760,
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
          id = 27,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1760,
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
          id = 28,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1824,
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
          id = 29,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1760,
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
          id = 30,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1984,
          y = 1872,
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
          x = 1888,
          y = 1856,
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
          x = 1984,
          y = 1936,
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
          x = 1984,
          y = 1904,
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
          x = 1824,
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
          id = 35,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1888,
          y = 1888,
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
          x = 1824,
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
          id = 37,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1792,
          y = 1984,
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
          x = 1792,
          y = 2016,
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
          x = 1825.33,
          y = 2112,
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
          x = 1728,
          y = 2112,
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
          x = 1728,
          y = 2144,
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
          x = 1392,
          y = 2176,
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
          x = 1424,
          y = 2176,
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
          x = 1424,
          y = 2208,
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
          id = 45,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1392,
          y = 2208,
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
          x = 1344,
          y = 1920,
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
          x = 1344,
          y = 1952,
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
          x = 1344,
          y = 1984,
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
          x = 1376,
          y = 1984,
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
          x = 1312,
          y = 2080,
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
          x = 1280,
          y = 2080,
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
          x = 1280,
          y = 1952,
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
          x = 1280,
          y = 1984,
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
          x = 1248,
          y = 1984,
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
          x = 1216,
          y = 2144,
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
          x = 1248,
          y = 2144,
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
          x = 1120,
          y = 1760,
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
          x = 1152,
          y = 1760,
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
          x = 1184,
          y = 1760,
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
          x = 1216,
          y = 1760,
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
          x = 1312,
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
          id = 66,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1056,
          y = 928,
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
          x = 1056,
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
          id = 68,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1312,
          y = 1088,
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
          x = 1216,
          y = 1120,
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
          x = 1216,
          y = 1151.33,
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
          x = 1248,
          y = 1568,
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
          id = 76,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1375.67,
          y = 1408,
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
          x = 1376,
          y = 1248,
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
          x = 1407.67,
          y = 1248,
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
          x = 1600,
          y = 1248,
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
          x = 1632,
          y = 1280,
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
          x = 1504,
          y = 1345.33,
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
          x = 1632,
          y = 1440,
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
          x = 1568,
          y = 1472,
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
          x = 1600.67,
          y = 1120,
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
          x = 1632,
          y = 1056,
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
          x = 1664,
          y = 1056,
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
          x = 1792.67,
          y = 1088,
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
          x = 1824,
          y = 1344,
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
          x = 1888,
          y = 1056,
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
          x = 1920,
          y = 1088,
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
          x = 1952,
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
          id = 96,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1792,
          y = 1472,
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
          x = 1472,
          y = 1568.08,
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
          x = 1504,
          y = 1696,
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
          x = 1664,
          y = 1728,
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
          x = 1504,
          y = 1728,
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
          x = 1536,
          y = 1984,
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
          x = 1760,
          y = 1760,
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
          x = 1760,
          y = 1792,
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
          x = 1888,
          y = 1760,
          width = 64,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Light"
          }
        },
        {
          id = 105,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1920,
          y = 1792,
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
          x = 1888,
          y = 1888,
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
          x = 1888,
          y = 2017,
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
          x = 1856,
          y = 2112,
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
          x = 1248,
          y = 1696,
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
          x = 1376,
          y = 1728,
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
          x = 1248,
          y = 1728,
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
          x = 1152,
          y = 1792,
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
          x = 1152,
          y = 1823.67,
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
          x = 1312.33,
          y = 1888.66,
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
          x = 1152,
          y = 1984,
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
          x = 1248,
          y = 2016,
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
          x = 1216,
          y = 2080,
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
          x = 1823.67,
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
          id = 121,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2016,
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
          id = 122,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2016,
          y = 1696,
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
          x = 1824,
          y = 2208,
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
          x = 1087,
          y = 2208,
          width = 448,
          height = 33,
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
          x = 1056,
          y = 1728,
          width = 31,
          height = 512,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 126,
          name = "",
          type = "",
          shape = "rectangle",
          x = 992,
          y = 1536,
          width = 30.6667,
          height = 30.6667,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Light"
          }
        },
        {
          id = 127,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1696,
          y = 2272,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Light"
          }
        },
        {
          id = 128,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1792,
          y = 864,
          width = 31.3333,
          height = 31.3333,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Light"
          }
        },
        {
          id = 129,
          name = "spawn_point_2",
          type = "",
          shape = "rectangle",
          x = 1856,
          y = 1504,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Player"
          }
        },
        {
          id = 130,
          name = "spawn_point_3",
          type = "",
          shape = "rectangle",
          x = 1856,
          y = 1600,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Player"
          }
        },
        {
          id = 131,
          name = "spawn_point_1",
          type = "",
          shape = "rectangle",
          x = 1952,
          y = 1504,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Player"
          }
        },
        {
          id = 133,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2080,
          y = 1440,
          width = 256,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 134,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2080,
          y = 1696,
          width = 256,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 135,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2527.33,
          y = 1440,
          width = 256.67,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 136,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2528,
          y = 1696,
          width = 256,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 137,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1984,
          y = 1728,
          width = 31.3333,
          height = 31.3333,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Light"
          }
        },
        {
          id = 138,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1760,
          y = 1504,
          width = 31.3333,
          height = 31.3333,
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
          x = 1632,
          y = 1728,
          width = 31.3333,
          height = 31.3333,
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
          x = 1344,
          y = 1728,
          width = 31.3333,
          height = 31.3333,
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
          x = 1280,
          y = 2016,
          width = 31.3333,
          height = 31.3333,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Light"
          }
        },
        {
          id = 142,
          name = "",
          type = "",
          shape = "rectangle",
          x = 576,
          y = 704,
          width = 383.546,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 144,
          name = "",
          type = "",
          shape = "rectangle",
          x = 576,
          y = 736,
          width = 32,
          height = 1728,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 145,
          name = "",
          type = "",
          shape = "rectangle",
          x = 608,
          y = 2432,
          width = 352,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 146,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1216,
          y = 2432,
          width = 864,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 147,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2048,
          y = 2240,
          width = 32,
          height = 192,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 148,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1216,
          y = 704,
          width = 864,
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
          x = 2048,
          y = 736,
          width = 32,
          height = 192,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Wall"
          }
        },
        {
          id = 153,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2360,
          y = 1472,
          width = 148.485,
          height = 69.697,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Light"
          }
        }
      }
    },
    {
      type = "objectgroup",
      name = "entity_layer_2",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 198,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2084,
          y = 1220,
          width = 249.333,
          height = 217.333,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Water"
          }
        },
        {
          id = 199,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2336.67,
          y = 1220.67,
          width = 212,
          height = 216,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Water"
          }
        },
        {
          id = 201,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2551.33,
          y = 1220.67,
          width = 225.333,
          height = 217.334,
          rotation = 0,
          visible = true,
          properties = {
            ["type"] = "Water"
          }
        }
      }
    }
  }
}
