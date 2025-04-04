//
//  ChessBoard.swift
//  Chess-protocol-practice
//
//  Created by 이유현 on 4/4/25.
//

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

// 2. 체스말 프로토콜
protocol ChessPiece {
    var pieceType : ChessPieceType {get}
    func move(from: (Int, Int), to: (Int, Int)) -> Bool
}

// 3. 말 구현
struct Queen: ChessPiece {
    var pieceType : ChessPieceType = .queen
    
    func move(from: (Int, Int), to: (Int, Int)) -> Bool {
        // 퀸은 상하좌우 및 대각선으로 자유롭게 이동 가능
        return true
    }
}

struct King: ChessPiece {
    var pieceType : ChessPieceType = .king
    
    func move(from: (Int, Int), to: (Int, Int)) -> Bool {
        // 킹은 상하좌우 및 대각선으로 한 칸만 이동 가능
        return true
    }
}

// 4. 체스판
class ChessBoard {
    // 체스판을 만들기 위해 2차원 배열을 만들어야 한다.
    // ChessPiece을 이용하여 킹, 퀸, 나이트, 폰 등의 타입을 ChessPiece으로 추상화하여 2차원 배열을 만들 수 있게된다.
    var board: [[ChessPiece?]] = Array(repeating: Array(repeating: nil, count: 8), count: 8)
    
    func placePiece(_ piece: ChessPiece, at position: (Int, Int)) {
        board[position.0][position.1] = piece
    }
    
    func movePiece(from: (Int, Int), to: (Int, Int)) {
        guard let piece = board[from.0][from.1] else {
            print("No piece at starting position")
            return
        }
        
        // 유저가 룰에 맞게 말을 옮기려고 할 때, 유저는 어떤 piece이던 간에 상관없이 move만 하면된다
        if piece.move(from: from, to: to) {
            board[to.0][to.1] = piece
            board[from.0][from.1] = nil
            print("\(piece.pieceType) moved from \(from) to \(to)")
        } else {
            print("Invalid move for \(piece.pieceType)")
        }
    }
    
    func startGame() {
        // 예시로 퀸과 킹만 배치
        placePiece(Queen(), at: (0, 3))
        placePiece(King(), at: (0, 4))
        
        print("Game started.")
    }
    
}

let chessBoard = ChessBoard()
chessBoard.startGame()
chessBoard.movePiece(from: (0, 3), to: (4, 7)) // 퀸 이동 예제
chessBoard.movePiece(from: (0, 4), to: (1, 4)) // 킹 이동 예제

