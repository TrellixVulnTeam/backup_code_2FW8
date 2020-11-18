package com.cong.utils
{
	import laya.maths.Point;
	import laya.maths.Rectangle;
	import laya.utils.Browser;

	public class UnistrokeRecognize
	{
		private const NumUnistrokes = 16;
		private const NumPoints = 64;
		private const SquareSize = 250.0;
		private const Origin = new Point(0, 0);
		private const Diagonal = Math.sqrt(SquareSize * SquareSize + SquareSize * SquareSize);
		private const AngleRange = Deg2Rad(45.0);
		private const AnglePrecision = Deg2Rad(2.0);
		private const Phi = 0.5 * (-1.0 + Math.sqrt(5.0)); // Golden Ratio

		private var _unistrokes:Array = new Array();

		public function UnistrokeRecognize()
		{
			this._unistrokes[0] = createUnistroke("triangle", new Array(new Point(137, 139), new Point(135, 141), new Point(133, 144), new Point(132, 146), new Point(130, 149), new Point(128, 151), new Point(126, 155), new Point(123, 160), new Point(120, 166), new Point(116, 171), new Point(112, 177), new Point(107, 183), new Point(102, 188), new Point(100, 191), new Point(95, 195), new Point(90, 199), new Point(86, 203), new Point(82, 206), new Point(80, 209), new Point(75, 213), new Point(73, 213), new Point(70, 216), new Point(67, 219), new Point(64, 221), new Point(61, 223), new Point(60, 225), new Point(62, 226), new Point(65, 225), new Point(67, 226), new Point(74, 226), new Point(77, 227), new Point(85, 229), new Point(91, 230), new Point(99, 231), new Point(108, 232), new Point(116, 233), new Point(125, 233), new Point(134, 234), new Point(145, 233), new Point(153, 232), new Point(160, 233), new Point(170, 234), new Point(177, 235), new Point(179, 236), new Point(186, 237), new Point(193, 238), new Point(198, 239), new Point(200, 237), new Point(202, 239), new Point(204, 238), new Point(206, 234), new Point(205, 230), new Point(202, 222), new Point(197, 216), new Point(192, 207), new Point(186, 198), new Point(179, 189), new Point(174, 183), new Point(170, 178), new Point(164, 171), new Point(161, 168), new Point(154, 160), new Point(148, 155), new Point(143, 150), new Point(138, 148), new Point(136, 148)));
			this._unistrokes[1] = createUnistroke("rectangle", new Array(new Point(78, 149), new Point(78, 153), new Point(78, 157), new Point(78, 160), new Point(79, 162), new Point(79, 164), new Point(79, 167), new Point(79, 169), new Point(79, 173), new Point(79, 178), new Point(79, 183), new Point(80, 189), new Point(80, 193), new Point(80, 198), new Point(80, 202), new Point(81, 208), new Point(81, 210), new Point(81, 216), new Point(82, 222), new Point(82, 224), new Point(82, 227), new Point(83, 229), new Point(83, 231), new Point(85, 230), new Point(88, 232), new Point(90, 233), new Point(92, 232), new Point(94, 233), new Point(99, 232), new Point(102, 233), new Point(106, 233), new Point(109, 234), new Point(117, 235), new Point(123, 236), new Point(126, 236), new Point(135, 237), new Point(142, 238), new Point(145, 238), new Point(152, 238), new Point(154, 239), new Point(165, 238), new Point(174, 237), new Point(179, 236), new Point(186, 235), new Point(191, 235), new Point(195, 233), new Point(197, 233), new Point(200, 233), new Point(201, 235), new Point(201, 233), new Point(199, 231), new Point(198, 226), new Point(198, 220), new Point(196, 207), new Point(195, 195), new Point(195, 181), new Point(195, 173), new Point(195, 163), new Point(194, 155), new Point(192, 145), new Point(192, 143), new Point(192, 138), new Point(191, 135), new Point(191, 133), new Point(191, 130), new Point(190, 128), new Point(188, 129), new Point(186, 129), new Point(181, 132), new Point(173, 131), new Point(162, 131), new Point(151, 132), new Point(149, 132), new Point(138, 132), new Point(136, 132), new Point(122, 131), new Point(120, 131), new Point(109, 130), new Point(107, 130), new Point(90, 132), new Point(81, 133), new Point(76, 133)));
			this._unistrokes[2] = createUnistroke("circle", new Array(new Point(127, 141), new Point(124, 140), new Point(120, 139), new Point(118, 139), new Point(116, 139), new Point(111, 140), new Point(109, 141), new Point(104, 144), new Point(100, 147), new Point(96, 152), new Point(93, 157), new Point(90, 163), new Point(87, 169), new Point(85, 175), new Point(83, 181), new Point(82, 190), new Point(82, 195), new Point(83, 200), new Point(84, 205), new Point(88, 213), new Point(91, 216), new Point(96, 219), new Point(103, 222), new Point(108, 224), new Point(111, 224), new Point(120, 224), new Point(133, 223), new Point(142, 222), new Point(152, 218), new Point(160, 214), new Point(167, 210), new Point(173, 204), new Point(178, 198), new Point(179, 196), new Point(182, 188), new Point(182, 177), new Point(178, 167), new Point(170, 150), new Point(163, 138), new Point(152, 130), new Point(143, 129), new Point(140, 131), new Point(129, 136), new Point(126, 139)));
			this._unistrokes[3] = createUnistroke("666", new Array(new Point(630,195),new Point(621,195),new Point(615,195),new Point(607,197),new Point(586,197),new Point(576,199),new Point(549,204),new Point(522,208),new Point(486,220),new Point(447,229),new Point(414,235),new Point(386,243),new Point(368,251),new Point(355,260),new Point(343,270),new Point(324,285),new Point(310,297),new Point(289,316),new Point(266,349),new Point(251,370),new Point(239,395),new Point(224,426),new Point(218,463),new Point(204,503),new Point(199,546),new Point(195,594),new Point(187,646),new Point(185,702),new Point(191,771),new Point(199,844),new Point(208,869),new Point(226,921),new Point(262,989),new Point(291,1020),new Point(324,1056),new Point(372,1083),new Point(443,1118),new Point(507,1135),new Point(553,1141),new Point(580,1141),new Point(596,1141),new Point(621,1128),new Point(661,1070),new Point(690,997),new Point(719,904),new Point(731,810),new Point(736,771),new Point(738,740),new Point(736,717),new Point(727,694),new Point(717,671),new Point(698,642),new Point(673,623),new Point(638,601),new Point(596,582),new Point(536,557),new Point(497,549),new Point(453,546),new Point(414,549),new Point(376,555),new Point(343,565),new Point(291,586),new Point(278,592),new Point(254,607),new Point(237,623),new Point(224,640),new Point(208,659),new Point(193,671),new Point(191,673),new Point(187,675),new Point(187,675)));
			this._unistrokes[4] = createUnistroke("caret", new Array(new Point(79, 245), new Point(79, 242), new Point(79, 239), new Point(80, 237), new Point(80, 234), new Point(81, 232), new Point(82, 230), new Point(84, 224), new Point(86, 220), new Point(86, 218), new Point(87, 216), new Point(88, 213), new Point(90, 207), new Point(91, 202), new Point(92, 200), new Point(93, 194), new Point(94, 192), new Point(96, 189), new Point(97, 186), new Point(100, 179), new Point(102, 173), new Point(105, 165), new Point(107, 160), new Point(109, 158), new Point(112, 151), new Point(115, 144), new Point(117, 139), new Point(119, 136), new Point(119, 134), new Point(120, 132), new Point(121, 129), new Point(122, 127), new Point(124, 125), new Point(126, 124), new Point(129, 125), new Point(131, 127), new Point(132, 130), new Point(136, 139), new Point(141, 154), new Point(145, 166), new Point(151, 182), new Point(156, 193), new Point(157, 196), new Point(161, 209), new Point(162, 211), new Point(167, 223), new Point(169, 229), new Point(170, 231), new Point(173, 237), new Point(176, 242), new Point(177, 244), new Point(179, 250), new Point(181, 255), new Point(182, 257)));
			this._unistrokes[5] = createUnistroke("zig-zag", new Array(new Point(307, 216), new Point(333, 186), new Point(356, 215), new Point(375, 186), new Point(399, 216), new Point(418, 186)));
			this._unistrokes[6] = createUnistroke("v", new Array(new Point(89, 164), new Point(90, 162), new Point(92, 162), new Point(94, 164), new Point(95, 166), new Point(96, 169), new Point(97, 171), new Point(99, 175), new Point(101, 178), new Point(103, 182), new Point(106, 189), new Point(108, 194), new Point(111, 199), new Point(114, 204), new Point(117, 209), new Point(119, 214), new Point(122, 218), new Point(124, 222), new Point(126, 225), new Point(128, 228), new Point(130, 229), new Point(133, 233), new Point(134, 236), new Point(136, 239), new Point(138, 240), new Point(139, 242), new Point(140, 244), new Point(142, 242), new Point(142, 240), new Point(142, 237), new Point(143, 235), new Point(143, 233), new Point(145, 229), new Point(146, 226), new Point(148, 217), new Point(149, 208), new Point(149, 205), new Point(151, 196), new Point(151, 193), new Point(153, 182), new Point(155, 172), new Point(157, 165), new Point(159, 160), new Point(162, 155), new Point(164, 150), new Point(165, 148), new Point(166, 146)));
			this._unistrokes[7] = createUnistroke("star", new Array(new Point(75, 250), new Point(75, 247), new Point(77, 244), new Point(78, 242), new Point(79, 239), new Point(80, 237), new Point(82, 234), new Point(82, 232), new Point(84, 229), new Point(85, 225), new Point(87, 222), new Point(88, 219), new Point(89, 216), new Point(91, 212), new Point(92, 208), new Point(94, 204), new Point(95, 201), new Point(96, 196), new Point(97, 194), new Point(98, 191), new Point(100, 185), new Point(102, 178), new Point(104, 173), new Point(104, 171), new Point(105, 164), new Point(106, 158), new Point(107, 156), new Point(107, 152), new Point(108, 145), new Point(109, 141), new Point(110, 139), new Point(112, 133), new Point(113, 131), new Point(116, 127), new Point(117, 125), new Point(119, 122), new Point(121, 121), new Point(123, 120), new Point(125, 122), new Point(125, 125), new Point(127, 130), new Point(128, 133), new Point(131, 143), new Point(136, 153), new Point(140, 163), new Point(144, 172), new Point(145, 175), new Point(151, 189), new Point(156, 201), new Point(161, 213), new Point(166, 225), new Point(169, 233), new Point(171, 236), new Point(174, 243), new Point(177, 247), new Point(178, 249), new Point(179, 251), new Point(180, 253), new Point(180, 255), new Point(179, 257), new Point(177, 257), new Point(174, 255), new Point(169, 250), new Point(164, 247), new Point(160, 245), new Point(149, 238), new Point(138, 230), new Point(127, 221), new Point(124, 220), new Point(112, 212), new Point(110, 210), new Point(96, 201), new Point(84, 195), new Point(74, 190), new Point(64, 182), new Point(55, 175), new Point(51, 172), new Point(49, 170), new Point(51, 169), new Point(56, 169), new Point(66, 169), new Point(78, 168), new Point(92, 166), new Point(107, 164), new Point(123, 161), new Point(140, 162), new Point(156, 162), new Point(171, 160), new Point(173, 160), new Point(186, 160), new Point(195, 160), new Point(198, 161), new Point(203, 163), new Point(208, 163), new Point(206, 164), new Point(200, 167), new Point(187, 172), new Point(174, 179), new Point(172, 181), new Point(153, 192), new Point(137, 201), new Point(123, 211), new Point(112, 220), new Point(99, 229), new Point(90, 237), new Point(80, 244), new Point(73, 250), new Point(69, 254), new Point(69, 252)));
			this._unistrokes[8] = createUnistroke("pigtail", new Array(new Point(81, 219), new Point(84, 218), new Point(86, 220), new Point(88, 220), new Point(90, 220), new Point(92, 219), new Point(95, 220), new Point(97, 219), new Point(99, 220), new Point(102, 218), new Point(105, 217), new Point(107, 216), new Point(110, 216), new Point(113, 214), new Point(116, 212), new Point(118, 210), new Point(121, 208), new Point(124, 205), new Point(126, 202), new Point(129, 199), new Point(132, 196), new Point(136, 191), new Point(139, 187), new Point(142, 182), new Point(144, 179), new Point(146, 174), new Point(148, 170), new Point(149, 168), new Point(151, 162), new Point(152, 160), new Point(152, 157), new Point(152, 155), new Point(152, 151), new Point(152, 149), new Point(152, 146), new Point(149, 142), new Point(148, 139), new Point(145, 137), new Point(141, 135), new Point(139, 135), new Point(134, 136), new Point(130, 140), new Point(128, 142), new Point(126, 145), new Point(122, 150), new Point(119, 158), new Point(117, 163), new Point(115, 170), new Point(114, 175), new Point(117, 184), new Point(120, 190), new Point(125, 199), new Point(129, 203), new Point(133, 208), new Point(138, 213), new Point(145, 215), new Point(155, 218), new Point(164, 219), new Point(166, 219), new Point(177, 219), new Point(182, 218), new Point(192, 216), new Point(196, 213), new Point(199, 212), new Point(201, 211)));
		}

		private function createUnistroke(name, points):Object
		{
			var data = {};
			data.Name = name;
			data.Points = this.Resample(points, NumPoints);
			var radians = this.IndicativeAngle(data.Points);
			data.Points = this.RotateBy(data.Points, -radians);
			data.Points = this.ScaleTo(data.Points, SquareSize);
			data.Points = this.TranslateTo(data.Points, this.Origin);
			data.Vector = this.Vectorize(data.Points); // for Protractor
			return data;
		}

		private function Resample(points, n)
		{
			var I = PathLength(points) / (n - 1); // interval length
			var D = 0.0;
			var newpoints = new Array(points[0]);
			for (var i = 1; i < points.length; i++)
			{
				var d = Distance(points[i - 1], points[i]);
				if ((D + d) >= I)
				{
					var qx = points[i - 1].x + ((I - D) / d) * (points[i].x - points[i - 1].x);
					var qy = points[i - 1].y + ((I - D) / d) * (points[i].y - points[i - 1].y);
					var q = new Point(qx, qy);
					newpoints[newpoints.length] = q; // append new point 'q'
					points.splice(i, 0, q); // insert 'q' at position i in points s.t. 'q' will be the next i
					D = 0.0;
				} else D += d;
			}
			if (newpoints.length == n - 1) // somtimes we fall a rounding-error short of adding the last point, so add it if so
				newpoints[newpoints.length] = new Point(points[points.length - 1].x, points[points.length - 1].y);
			return newpoints;
		}

		private function IndicativeAngle(points)
		{
			var c = Centroid(points);
			return Math.atan2(c.y - points[0].y, c.x - points[0].x);
		}

		private function Vectorize(points) // for Protractor
		{
			var sum = 0.0;
			var vector = new Array();
			for (var i = 0; i < points.length; i++)
			{
				vector[vector.length] = points[i].x;
				vector[vector.length] = points[i].y;
				sum += points[i].x * points[i].x + points[i].y * points[i].y;
			}
			var magnitude = Math.sqrt(sum);
			for (var i = 0; i < vector.length; i++) vector[i] /= magnitude;
			return vector;
		}

		private function OptimalCosineDistance(v1, v2) // for Protractor
		{
			var a = 0.0;
			var b = 0.0;
			for (var i = 0; i < v1.length; i += 2)
			{
				a += v1[i] * v2[i] + v1[i + 1] * v2[i + 1];
				b += v1[i] * v2[i + 1] - v1[i + 1] * v2[i];
			}
			var angle = Math.atan(b / a);
			return Math.acos(a * Math.cos(angle) + b * Math.sin(angle));
		}

		private function DistanceAtBestAngle(points, T, a, b, threshold)
		{
			var x1 = Phi * a + (1.0 - Phi) * b;
			var f1 = DistanceAtAngle(points, T, x1);
			var x2 = (1.0 - Phi) * a + Phi * b;
			var f2 = DistanceAtAngle(points, T, x2);
			while (Math.abs(b - a) > threshold)
			{
				if (f1 < f2)
				{
					b = x2;
					x2 = x1;
					f2 = f1;
					x1 = Phi * a + (1.0 - Phi) * b;
					f1 = DistanceAtAngle(points, T, x1);
				} else
				{
					a = x1;
					x1 = x2;
					f1 = f2;
					x2 = (1.0 - Phi) * a + Phi * b;
					f2 = DistanceAtAngle(points, T, x2);
				}
			}
			return Math.min(f1, f2);
		}

		private function DistanceAtAngle(points, T, radians)
		{
			var newpoints = RotateBy(points, radians);
			return PathDistance(newpoints, T.Points);
		}

		private function RotateBy(points, radians) // rotates points around centroid
		{
			var c = Centroid(points);
			var cos = Math.cos(radians);
			var sin = Math.sin(radians);
			var newpoints = new Array();
			for (var i = 0; i < points.length; i++)
			{
				var qx = (points[i].x - c.x) * cos - (points[i].y - c.y) * sin + c.x
				var qy = (points[i].x - c.x) * sin + (points[i].y - c.y) * cos + c.y;
				newpoints[newpoints.length] = new Point(qx, qy);
			}
			return newpoints;
		}

		private function ScaleTo(points, size) // non-uniform scale; assumes 2D gestures (i.e., no lines)
		{
			var B = BoundingBox(points);
			var newpoints = new Array();
			for (var i = 0; i < points.length; i++)
			{
				var qx;
				if( B.width){
					qx= points[i].x * (size / B.width);
				}else{
					qx = 0;
				}
				var qy;
				if(B.height){
					qy = points[i].y * (size / B.height);
				}else{
					qy = 0;
				}
				newpoints[newpoints.length] = new Point(qx, qy);
			}
			return newpoints;
		}

		private function TranslateTo(points, pt) // translates points' centroid
		{
			var c = Centroid(points);
			var newpoints = new Array();
			for (var i = 0; i < points.length; i++)
			{
				var qx = points[i].x + pt.x - c.x;
				var qy = points[i].y + pt.y - c.y;
				newpoints[newpoints.length] = new Point(qx, qy);
			}
			return newpoints;
		}

		private function Centroid(points)
		{
			var x = 0.0, y = 0.0;
			for (var i = 0; i < points.length; i++)
			{
				x += points[i].x;
				y += points[i].y;
			}
			x /= points.length;
			y /= points.length;
			return new Point(x, y);
		}

		private function BoundingBox(points)
		{
			var minX = +Infinity, maxX = -Infinity, minY = +Infinity, maxY = -Infinity;
			for (var i = 0; i < points.length; i++)
			{
				minX = Math.min(minX, points[i].x);
				minY = Math.min(minY, points[i].y);
				maxX = Math.max(maxX, points[i].x);
				maxY = Math.max(maxY, points[i].y);
			}
			return new Rectangle(minX, minY, maxX - minX, maxY - minY);
		}

		private function PathDistance(pts1, pts2)
		{
			var d = 0.0;
			for (var i = 0; i < pts1.length; i++) // assumes pts1.length == pts2.length
				d += Distance(pts1[i], pts2[i]);
			return d / pts1.length;
		}

		private function PathLength(points)
		{
			var d = 0.0;
			for (var i = 1; i < points.length; i++) d += Distance(points[i - 1], points[i]);
			return d;
		}

		private function Distance(p1, p2)
		{
			var dx = p2.x - p1.x;
			var dy = p2.y - p1.y;
			return Math.sqrt(dx * dx + dy * dy);
		}

		private function Deg2Rad(d)
		{
			return (d * Math.PI / 180.0);
		}

		public function addGesture(name, points)
		{
			this._unistrokes[this._unistrokes.length] = createUnistroke(name, points); // append new unistroke
			var num = 0;
			for (var i = 0; i < this._unistrokes.length; i++)
			{
				if (this._unistrokes[i].Name == name) num++;
			}
			return num;
		}

		public function deleteUserGestures()
		{
			this._unistrokes.length = NumUnistrokes; // clear any beyond the original set
			return NumUnistrokes;
		}

		/**
		 * 识别
		 * @param points
		 * @param useProtractor true:用量角器（快）.false:黄金分割搜索
		 * @returns {Result}
		 * @constructor
		 */
		public function recognize(points, useProtractor:Boolean = false):Object
		{
			var t0 = Browser.now();
			points = Resample(points, NumPoints);
			var radians = IndicativeAngle(points);
			points = RotateBy(points, -radians);
			points = ScaleTo(points, SquareSize);
			points = TranslateTo(points, Origin);
			var vector = Vectorize(points); // for Protractor

			var b = 50;
			var u = -1;
			for (var i = 0; i < this._unistrokes.length; i++) // for each unistroke
			{
				var d;
				if (useProtractor) // for Protractor
					d = OptimalCosineDistance(this._unistrokes[i].Vector, vector); else // Golden Section Search (original $1)
					d = DistanceAtBestAngle(points, this._unistrokes[i], -AngleRange, +AngleRange, AnglePrecision);
				if (d < b)
				{
					b = d; // best (least) distance
					u = i; // unistroke index
				}
			}
			var t1 = Browser.now();
			return (u == -1) ? {name: "No match.", score: 0.0, time: t1 - t0} : {
				name: this._unistrokes[u].Name,
				score: b,
				time: t1 - t0
			};
		}

		public function get unistrokes():Array
		{
			return _unistrokes;
		}
	}
}
