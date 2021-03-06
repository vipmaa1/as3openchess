package de.robinz.as3.pcc.chessboard.library {

import de.robinz.as3.pcc.chessboard.library.pieces.IPiece;
import de.robinz.as3.pcc.chessboard.library.vo.ChessboardFieldVO;
import de.robinz.as3.pcc.chessboard.library.vo.ChessboardGameVO;
import de.robinz.as3.pcc.chessboard.library.vo.PiecePositionVO;
import de.robinz.as3.pcc.chessboard.view.views.chessboard.ChessboardField;

import flash.filters.BitmapFilter;
import flash.filters.BitmapFilterQuality;
import flash.filters.GlowFilter;

import mx.effects.Glow;
import mx.logging.ILogger;
import mx.logging.Log;

/**
 * ChessboardUtil
 *
 * @author robin heinel
 */
public class ChessboardUtil {

	private static const LOGGER : String = "ChessboardUtil";
	private static var log : ILogger = Log.getLogger( LOGGER );


	public static function getPieceFilters( color : int ) : Array {
		var f : GlowFilter = new GlowFilter();
		f.blurX = 1.5;
		f.blurY = 1.3;
		f.color = color;
		f.quality = BitmapFilterQuality.HIGH;
		f.strength = 4;

		var filters : Array = new Array();
		filters.push( f );
		return filters;
	}

	public static function createBoardField( notation : String, isWhite : Boolean, whiteColor : int = 0xffffff, blackColor : int = 0xbbbbbb ) : ChessboardField {
		var f : ChessboardField = new ChessboardField();
		f.id = notation;
		f.percentWidth = 12.5;
		f.percentHeight = 100;
		f.styleName = CssSelectors.BOARD_FIELD;
		f.setStyle( CssProperties.BACKGROUND_COLOR, isWhite ? whiteColor : blackColor );

		var vo : ChessboardFieldVO = new ChessboardFieldVO();
		vo.isWhite = isWhite;
		vo.notation = FieldNotation.createNotationByString( notation );
		f.data = vo;

		return f;
	}

	public static function getNotationSequence() : Array {
		var sequence : Array = new Array();
		var rows : String = "abcdefgh";
		var notation : String;

		var i : int = 1;
		var j : int = 1;

		for( j = 8; j > 0; j-- ) {
			for( i; i <= rows.length; i++ ) {
				notation = rows.charAt( i - 1 ) + j.toString();
				sequence.push( notation );
			}
			i = 1;
		}

		return sequence;
	}

	public static function getPieceMove( parentMove : ChessboardMove, fromNotation : String, toNotation : String ) : ChessboardMove {
		var move : ChessboardMove = new ChessboardMove();
		move.fromField = FieldNotation.createNotationByString( fromNotation );
		move.toField = FieldNotation.createNotationByString( toNotation );
		move.position = parentMove.position;
		move.game = parentMove.game;
		move.piece = parentMove.position.getPieceAt( fromNotation );
		move.validMoves = parentMove.validMoves;
		move.validMove = parentMove.validMove;

		return move;
	}

	public static function convertNotationCollection2ChessboardMoveCollection(
		from : FieldNotation,
		fields : FieldNotationCollection,
		position:ChessPosition,
		piece : IPiece) : ChessboardMoveCollection {

		var moves:ChessboardMoveCollection = new ChessboardMoveCollection();
		var move:ChessboardMove;

		for ( var i:int = 0; i < fields.length; i++ ) {
			move = new ChessboardMove();
			move.fromField = from;
			move.toField   = fields.getAt( i );
			move.beatenPiece  = position.getPieceAt( fields.getAt( i ).getNotation() );
			move.piece = piece;
			moves.add( move );

		}

		return moves;

	}

	public static function getValidMoves( game : ChessboardGameVO, position : ChessPosition, piece : PiecePositionVO ) : ChessboardMoveCollection {
		var validator : MoveValidator = new MoveValidator( game, position, piece );
		return validator.getValidMoves();
	}
}
}