import Foundation

// 1. 체스말 종류
enum ChessPieceType {
    case king
    case queen
    case rook
    case bishop
    case knight
    case pawn
}

// 2. 체스말 클래스
class ChessPiece {
    let pieceType: ChessPieceType
    
    init(type: ChessPieceType) {
        self.pieceType = type
    }
    
    func move(from: (Int, Int), to: (Int, Int)) -> Bool {
        return false // 기본적으로 이동 불가능
    }
}

// 3. 개별 체스말 클래스
class Queen: ChessPiece {
    init() {
        super.init(type: .queen)
    }
    
    func canMove(from: (Int, Int), to: (Int, Int)) -> Bool {
        // 퀸은 상하좌우 및 대각선으로 자유롭게 이동 가능
        return true
    }
}

class King: ChessPiece {
    init() {
        super.init(type: .king)
    }
    
    func canMove(from: (Int, Int), to: (Int, Int)) -> Bool {
        // 킹은 상하좌우 및 대각선으로 한 칸만 이동 가능
        return true
    }
}

// 4. 체스판 클래스
class ChessBoard {
    var board: [[ChessPiece?]] = Array(repeating: Array(repeating: nil, count: 8), count: 8)
    
    func placePiece(_ piece: ChessPiece, at position: (Int, Int)) {
        board[position.0][position.1] = piece
    }
    
    func movePiece(from: (Int, Int), to: (Int, Int)) {
        guard let piece = board[from.0][from.1] else {
            print("No piece at starting position")
            return
        }
        
        var isValidMove = false
        
        // 프로토콜을 사용하지 않았기 때문에 체스 피스의 각각 타입을 확인해야한다.
        if let queen = piece as? Queen {
            isValidMove = queen.canMove(from: from, to: to)
        } else if let king = piece as? King {
            isValidMove = king.canMove(from: from, to: to)
        }
        
        if isValidMove {
            board[to.0][to.1] = piece
            board[from.0][from.1] = nil
            print("\(piece.pieceType) moved from \(from) to \(to)")
        } else {
            print("Invalid move for \(piece.pieceType)")
        }
    }
    
    func startGame() {
        placePiece(Queen(), at: (0, 3))
        placePiece(King(), at: (0, 4))
        print("Game started.")
    }
}

let chessBoard = ChessBoard()
chessBoard.startGame()
chessBoard.movePiece(from: (0, 3), to: (4, 7)) // 퀸 이동 예제
chessBoard.movePiece(from: (0, 4), to: (1, 4)) // 킹 이동 예제
