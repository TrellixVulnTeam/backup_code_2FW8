import React from "react"
import ReactDOM from "react-dom"
import "./index.css"

function Square(props) {
    return (
        <button
            className="square"
            onClick={props.onClick}
        >
            {props.value}
        </button>
    );
}

class Board extends React.Component {
    renderSquare(i) {
        return <Square
            key={i}
            value={this.props.squares[i]}
            onClick={() => this.props.onClick(i)}
        />;
    }

    render() {
        const elements = this.props.squares.map((v, i) => this.renderSquare(i))
        const container = []
        for (let i = 0; i < elements.length; i += 3) {
            container.push(
                <div key={i} className="board-row">
                    {elements.slice(i, i + 3)}
                </div>
            )
        }

        return (
            <div>
                {container}
            </div>
        );
    }
}

class Game extends React.Component {
    constructor(props) {
        super(props)
        this.state = {
            history: [{
                squares: new Array(9).fill(null),
                point: null,
            }],
            xIsNext: true,
            stepNumber: 0,
        }
    }

    render() {
        const history = this.state.history
        const current = history[history.length - 1]
        const winner = calculateWinner(current.squares)

        let status
        if (winner) {
            status = `Winner: ${winner}`
        } else {
            status = `Next player: ${this.state.xIsNext ? 'X' : 'O'}`
        }

        return (
            <div className="game">
                {/* <Timer /> */}
                <div className="game-board">
                    <Board
                        squares={current.squares}
                        onClick={i => this.handleClick(i)} />
                </div>
                <div className="game-info">
                    <div>{status}</div>
                    <HistoryShow
                        history={this.state.history}
                        stepNumber={this.state.stepNumber}
                        jumpTo={this.jumpTo.bind(this)} />
                </div>
            </div>
        );
    }

    handleClick(i) {
        const history = this.state.history
        const current = history[this.state.stepNumber]
        const squares = current.squares.slice()

        if (calculateWinner(squares) || squares[i]) {
            return
        }

        squares[i] = this.state.xIsNext ? "X" : "O"
        this.setState({
            history: history.concat([
                {
                    squares: squares,
                    point: {
                        col: i % 3,
                        row: Math.floor(i / 3)
                    },
                }
            ]),
            xIsNext: !this.state.xIsNext,
            stepNumber: history.length
        })
    }

    jumpTo(step) {

        this.setState({
            stepNumber: step,
            xIsNext: (step % 2) === 0
        })
    }
}

class HistoryShow extends React.Component {
    constructor(props) {
        super(props)
        this.state = {
            isreverse: false,
        }
    }

    render() {
        const history = this.props.history
        const stepNumber = this.props.stepNumber
        let moves = history.map((step, move) => {
            const desc = move ?
                `Go to move row(${step.point.row}), col(${step.point.col})` :
                "Go to game start"
            return (
                <li key={move}>
                    <button className={stepNumber === move ? "bold" : ""} onClick={() => this.props.jumpTo(move)}>{desc}</button>
                </li>
            )
        })

        if (this.state.isreverse) {
            moves = moves.reverse()
        }

        return (
            <div>
                <button onClick={this.reverseSort.bind(this)}> reverse </button>
                <ol>
                    {moves}
                </ol>
            </div>
        )
    }

    reverseSort() {
        this.setState({
            isreverse: !this.state.isreverse
        })
    }

}

function calculateWinner(squares) {
    const b = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [2, 4, 6],
    ].find(arr => {
        return squares[arr[0]] !== null &&
            squares[arr[0]] === squares[arr[1]] &&
            squares[arr[2]] === squares[arr[1]]
    })

    return b ? squares[b[0]] : null
}

// ========================================

ReactDOM.render(
    <Game />,
    document.getElementById('root')
);
