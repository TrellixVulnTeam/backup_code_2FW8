package com.cong.utils {

    public class EdgeGraph extends Graph {

        private var _start:*;
        private var _end:*;

        public function EdgeGraph() {
        }

        public function reset(start:*, end:*)  {
            _start = start;
            _end = end;
            this.vertexs = [];
            this.edges.clear();
        }

        //添加一个点
        public function addPoint(v:*):void {
            //获得最后一个插入的点
            var prevVertex = lastVertex;
            addVertex(v);
            addEdge(prevVertex, v);
        }

        public function get start():String {
            return _start;
        }

        public function get end():String {
            return _end;
        }

        public function get firstVertex():String {
            return this.vertexs[0];
        }

        public function get lastVertex():String {
            return this.vertexs[this.vertexs.length - 1];
        }
    }

}
