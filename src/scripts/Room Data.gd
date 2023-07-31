extends Node

var right_portal_position : Array = [1800, 935]
var left_portal_position : Array = [180, 935]

var room_data : Array = [
# Room Zero Tile Data
[[1, 3], [1, 4], [1, 5], [1, 6], [1, 7], [1, 8], [1, 12], [1, 13], [1, 14], [2, 5], [2, 6], [2, 7], [2, 8], [2, 12], [2, 13], [2, 14], [3, 5], [3, 8], [3, 13], [3, 14], [4, 4], [4, 5], [4, 8], [4, 9], [4, 10], [4, 13], [4, 14], [5, 8], [5, 9], [5, 10], [5, 13], [5, 14], [6, 9], [6, 10], [6, 13], [6, 14], [7, 5], [7, 13], [7, 14], [8, 4], [8, 5], [9, 5], [9, 11], [10, 5], [10, 6], [10, 7], [10, 8], [10, 11], [11, 2], [11, 3], [11, 4], [11, 5], [11, 6], [11, 7], [11, 8], [11, 11], [12, 2], [12, 8], [12, 11], [12, 12], [12, 13], [13, 2], [13, 12], [13, 13], [13, 14], [14, 2], [14, 12], [14, 13], [14, 14], [15, 2], [15, 7], [15, 10], [15, 13], [15, 14], [16, 2], [16, 7], [16, 10], [16, 13], [16, 14], [17, 2], [17, 5], [17, 6], [17, 7], [17, 10], [17, 13], [17, 14], [18, 2], [18, 6], [18, 7], [18, 13], [18, 14], [19, 2], [19, 6], [19, 7], [19, 8], [19, 11], [19, 12], [19, 13], [19, 14], [20, 2], [20, 6], [20, 7], [20, 8], [20, 11], [20, 12], [20, 13], [20, 14], [21, 2], [21, 6], [21, 7], [21, 8], [21, 12], [21, 13], [21, 14], [22, 2], [22, 3], [22, 4], [22, 5], [22, 6], [22, 7], [22, 8], [22, 12], [22, 13], [22, 14]],
 
# Room One Tile Data
[[1, 5], [1, 6], [1, 7], [1, 8], [1, 9], [1, 12], [1, 13], [1, 14], [2, 1], [2, 8], [2, 9], [2, 12], [2, 13], [2, 14], [3, 1], [3, 8], [3, 9], [3, 12], [3, 13], [3, 14], [4, 1], [4, 5], [4, 8], [4, 9], [4, 12], [4, 13], [4, 14], [5, 1], [5, 7], [5, 8], [5, 9], [5, 12], [5, 13], [5, 14], [6, 1], [6, 9], [6, 12], [6, 13], [6, 14], [7, 1], [7, 5], [7, 12], [7, 13], [7, 14], [8, 4], [8, 5], [8, 12], [9, 4], [9, 5], [9, 12], [10, 4], [10, 5], [10, 6], [10, 7], [10, 8], [11, 1], [11, 4], [11, 5], [11, 6], [11, 7], [11, 8], [12, 1], [12, 5], [12, 6], [12, 7], [12, 8], [12, 11], [12, 12], [12, 13], [13, 1], [13, 5], [13, 8], [13, 11], [13, 12], [13, 13], [13, 14], [14, 1], [14, 5], [14, 8], [14, 11], [14, 12], [14, 13], [14, 14], [15, 1], [15, 5], [15, 12], [15, 13], [15, 14], [16, 1], [16, 2], [16, 3], [16, 4], [16, 5], [16, 10], [16, 12], [16, 13], [16, 14], [17, 1], [17, 2], [17, 10], [17, 12], [17, 13], [17, 14], [18, 1], [18, 2], [18, 12], [18, 13], [18, 14], [19, 1], [19, 2], [19, 8], [19, 12], [19, 13], [19, 14], [20, 1], [20, 2], [20, 8], [20, 12], [20, 13], [20, 14], [21, 1], [21, 2], [21, 3], [21, 4], [21, 5], [21, 6], [21, 7], [21, 8], [21, 12], [21, 13], [21, 14], [22, 1], [22, 2], [22, 3], [22, 4], [22, 5], [22, 6], [22, 7], [22, 8], [22, 12], [22, 13], [22, 14]],

# Room Two Tile Data
[[1, 3], [1, 4], [1, 5], [1, 6], [1, 7], [1, 8], [1, 9], [1, 13], [1, 14], [2, 1], [2, 3], [2, 4], [2, 5], [2, 6], [2, 7], [2, 8], [2, 9], [2, 12], [2, 13], [2, 14], [3, 1], [3, 3], [3, 4], [3, 5], [3, 6], [3, 7], [3, 8], [3, 9], [3, 13], [3, 14], [4, 1], [4, 3], [4, 4], [4, 5], [4, 6], [4, 7], [4, 8], [4, 9], [4, 13], [4, 14], [5, 1], [5, 3], [5, 4], [5, 5], [5, 6], [5, 7], [5, 8], [5, 9], [5, 13], [5, 14], [6, 1], [6, 5], [6, 7], [6, 8], [6, 9], [6, 12], [6, 13], [6, 14], [7, 1], [7, 5], [7, 7], [7, 13], [7, 14], [8, 7], [8, 14], [9, 3], [9, 7], [10, 3], [10, 10], [11, 1], [11, 3], [11, 10], [12, 1], [12, 2], [12, 3], [12, 8], [12, 10], [12, 12], [12, 13], [13, 1], [13, 2], [13, 3], [13, 8], [13, 12], [13, 13], [13, 14], [14, 1], [14, 2], [14, 3], [14, 8], [14, 12], [14, 13], [14, 14], [15, 1], [15, 2], [15, 3], [15, 12], [15, 13], [15, 14], [16, 1], [16, 2], [16, 3], [16, 12], [16, 13], [16, 14], [17, 1], [17, 2], [17, 3], [17, 4], [17, 5], [17, 6], [17, 7], [17, 8], [17, 12], [17, 13], [17, 14], [18, 1], [18, 2], [18, 3], [18, 4], [18, 5], [18, 6], [18, 7], [18, 8], [18, 11], [18, 12], [18, 13], [18, 14], [19, 1], [19, 2], [19, 3], [19, 4], [19, 5], [19, 6], [19, 7], [19, 8], [19, 11], [19, 12], [19, 13], [19, 14], [20, 1], [20, 2], [20, 3], [20, 4], [20, 5], [20, 6], [20, 7], [20, 8], [20, 12], [20, 13], [20, 14], [21, 1], [21, 2], [21, 3], [21, 4], [21, 5], [21, 6], [21, 7], [21, 8], [21, 12], [21, 13], [21, 14], [22, 1], [22, 2], [22, 3], [22, 4], [22, 5], [22, 6], [22, 7], [22, 8], [22, 12], [22, 13], [22, 14]],

# Room Three Tile Data
[[1, 3], [1, 4], [1, 5], [1, 6], [1, 7], [1, 8], [1, 13], [1, 14], [2, 3], [2, 4], [2, 5], [2, 6], [2, 7], [2, 8], [2, 13], [2, 14], [3, 1], [3, 3], [3, 4], [3, 5], [3, 6], [3, 11], [3, 12], [3, 13], [3, 14], [4, 1], [4, 3], [4, 4], [4, 5], [4, 6], [4, 11], [4, 12], [4, 13], [4, 14], [5, 1], [5, 3], [5, 4], [5, 5], [5, 6], [5, 13], [5, 14], [6, 1], [6, 4], [6, 13], [6, 14], [7, 1], [7, 4], [7, 9], [7, 14], [8, 4], [8, 9], [8, 14], [9, 4], [9, 9], [9, 12], [10, 8], [10, 9], [10, 12], [11, 1], [11, 6], [11, 7], [11, 8], [11, 12], [12, 1], [12, 2], [12, 3], [12, 4], [12, 5], [12, 6], [12, 7], [12, 8], [13, 1], [13, 2], [13, 3], [13, 4], [13, 5], [13, 6], [13, 7], [13, 8], [13, 14], [14, 1], [14, 6], [14, 11], [14, 13], [14, 14], [15, 1], [15, 6], [15, 11], [15, 14], [16, 1], [16, 11], [16, 14], [17, 1], [17, 11], [17, 14], [18, 1], [18, 8], [18, 13], [18, 14], [19, 1], [19, 5], [19, 8], [19, 14], [20, 1], [20, 5], [20, 8], [20, 14], [21, 1], [21, 5], [21, 8], [21, 11], [21, 12], [21, 13], [21, 14], [22, 1], [22, 2], [22, 3], [22, 4], [22, 5], [22, 6], [22, 7], [22, 8], [22, 11], [22, 12], [22, 13], [22, 14]],

# Room Four Tile Data
[[1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7], [1, 8], [1, 13], [1, 14], [2, 3], [2, 6], [2, 14], [3, 6], [3, 14], [4, 1], [4, 6], [4, 12], [4, 14], [5, 1], [5, 6], [5, 11], [5, 12], [5, 14], [6, 1], [6, 10], [6, 11], [6, 14], [7, 1], [7, 4], [7, 8], [7, 10], [7, 11], [7, 14], [8, 4], [8, 8], [8, 10], [8, 14], [9, 4], [9, 8], [9, 9], [9, 10], [9, 11], [10, 4], [10, 8], [10, 10], [10, 11], [11, 1], [11, 4], [11, 8], [11, 10], [11, 11], [12, 1], [12, 4], [12, 8], [12, 10], [12, 11], [13, 1], [13, 6], [13, 10], [13, 11], [13, 14], [14, 1], [14, 6], [14, 10], [14, 11], [14, 14], [15, 1], [15, 8], [15, 10], [15, 14], [16, 1], [16, 8], [16, 10], [16, 11], [16, 14], [17, 1], [17, 5], [17, 8], [17, 9], [17, 10], [17, 11], [17, 12], [17, 14], [18, 1], [18, 5], [18, 11], [18, 12], [18, 14], [19, 1], [19, 5], [19, 12], [19, 14], [20, 1], [20, 5], [20, 14], [21, 1], [21, 5], [21, 14], [22, 1], [22, 2], [22, 3], [22, 4], [22, 5], [22, 6], [22, 7], [22, 8], [22, 12], [22, 13], [22, 14]]




]



var enemy_data : Array = [
# Room Zero Enemy Data
[[840, 372], [1268, 1004], [1512, 440], [208, 368]], 

# Room One Enemy Data
[[351, 607], [1228, 364], [1255, 941], [337, 928]],

# Room Two Enemy Data
[[480, 1028], [1674, 935], [663, 543]],

# Room Three Enemy Data
[[535, 288], [1301, 1101], [1700, 369]],

# Room Four Enemy Data
[[902, 770], [778, 286], [1710, 1090], [222, 1078]]


]


var coin_data : Array = [
# Room Zero Coin Data
[[1775, 118], [279, 581], [279, 981], [1683, 333], [1751, 817]], 

# Room One Coin Data
[[224, 562], [526, 587], [1024, 355], [1620, 395], [1612, 839]],

# Room Two Coin Data
[[277, 919], [884, 198], [534, 516], [1363, 879], [1092, 489]],

# Room Three Coin Data
[[328, 813], [908, 409], [1179, 423], [1593, 1060]],

# Room Four Coin Data
[[1238, 925], [681, 932], [238, 403], [1710, 307], [1312, 759]]


]


func size() -> int:
	return len(room_data)
