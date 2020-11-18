package com.cong.utils {

    import laya.utils.Dictionary;

    public class Graph {

        protected var vertexs:Array;
        protected var edges:Dictionary;
        //逻辑顶点集合
        private var logicVertexs:Dictionary;

        public function Graph() {
            vertexs = [];
            edges = new Dictionary();
            logicVertexs = new Dictionary();
        }

        //添加顶点
        public function addVertex(vertex:*, islogic:Boolean = false):void {
            if (vertexs.indexOf(vertex) != -1) {
                return
            }
            vertexs.push(vertex);
            edges.set(vertex, []);
            if (islogic) {
                logicVertexs.set(vertex, true);
            }
        }

        //添加边
        public function addEdge(v:*, u:*):void {
            if(edges.get(v) == null || edges.get(u) == null) {
                return;
            }

            if (edges.get(v).indexOf(u) != -1 || edges.get(u).indexOf(v) != -1) {
                return
            }

            edges.get(v).push(u);
            edges.get(u).push(v);
        }

        public function removeEdge(v:*, u:*):void {
            if(edges.get(v) == null || edges.get(u) == null) {
                return;
            }

            var vIndex:int = edges.get(v).indexOf(u);
            var uIndex:int = edges.get(u).indexOf(v);
            if (vIndex != -1 || uIndex != -1) {
                edges.get(v).splice(vIndex, 1);
                edges.get(u).splice(uIndex, 1);
            }
        }

        public function addVertexAndEdge(v:*, u:*):void {
            addVertex(v);
            addVertex(u);
            addEdge(v, u);
        }

        //添加所有的边
        public function merge(otherGraph):void {
            for each (var v:* in otherGraph.vertexs) {
                addVertex(v);
                var vEdge:Array = edges.get(v);
                for each(var e:* in otherGraph.edges.get(v)) {
                    addEdge(v, e);
                }
            }
        }

        //合并边图start, end(逻辑上的顶点,实际存在,使用时忽略)
        public function mergeEdgeGraph(edge:EdgeGraph):void {
            //舍弃自环
            if (edge.start == edge.end) return;
            //中间点合并
            merge(edge);

            //与原表进行连接
            //顶点元素连接
            addVertex(edge.start, true);
            addEdge(edge.start, edge.firstVertex);

            //尾元素连接
            addVertex(edge.end, true);
            addEdge(edge.end, edge.lastVertex);

            if (edge.vertexs.length < 1) {
                addEdge(edge.start, edge.end);
            } else {
                removeEdge(edge.start, edge.end);
            }
        }

        //深度搜索
        /**
         *
         * @param startVertex 起始顶点
         * @param step 限制搜索步数
         */
        public function dfs(startVertex:*, step:int):Array {
            //保存已访问到的顶点
            var flags:Dictionary = new Dictionary();
            //待访问的顶点,做为栈使用
            var stack:Array = [startVertex];
            flags.set(startVertex, 0);
            return dfsIter(stack, flags, step);
        }


        private function dfsIter(stack:Array, flags:Dictionary, step:int):Array {
            var result:Array = [];

            while (stack.length > 0) {
                var vertex:* = stack.pop();
                var vStep:int = flags.get(vertex);
                result.push(vertex);
                if (vStep >= step) {
                    continue;
                }

                var neighbors:Array = edges.get(vertex);

                for each (var u:* in neighbors) {
                    //标识这个顶点已探索到以及其深度
                    if (flags.get(u) == null) {
                        if (logicVertexs.get(u) == true) {
                            flags.set(u, vStep);
                        } else {
                            flags.set(u, vStep + 1);
                        }
                        stack.push(u);
                    }
                }
            }

            return result;
        }
    }
}
