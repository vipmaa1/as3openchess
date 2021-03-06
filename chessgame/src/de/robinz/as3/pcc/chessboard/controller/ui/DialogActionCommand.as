package de.robinz.as3.pcc.chessboard.controller.ui {
import de.robinz.as3.pcc.chessboard.ApplicationFacade;
import de.robinz.as3.pcc.chessboard.controller.BaseCommand;
import de.robinz.as3.pcc.chessboard.library.common.LoggerUtil;
import de.robinz.as3.pcc.chessboard.library.vo.BoardSettingsVO;
import de.robinz.as3.pcc.chessboard.library.vo.ColorSettingsAppearVO;
import de.robinz.as3.pcc.chessboard.library.vo.ColorSettingsVO;
import de.robinz.as3.pcc.chessboard.library.vo.PieceSettingsVO;
import de.robinz.as3.pcc.chessboard.model.FontProxy;
import de.robinz.as3.pcc.chessboard.view.BoardSettingsMediator;
import de.robinz.as3.pcc.chessboard.view.ColorSettingsMediator;
import de.robinz.as3.pcc.chessboard.view.MoveHistoryMediator;
import de.robinz.as3.pcc.chessboard.view.MoveHistoryModifierMediator;
import de.robinz.as3.pcc.chessboard.view.PawnConvertMediator;
import de.robinz.as3.pcc.chessboard.view.PieceSettingsMediator;
import de.robinz.as3.pcc.chessboard.view.TakenPiecesMediator;

import de.robinz.as3.pcc.chessboard.view.views.game.BoardSettingsDialog;
import de.robinz.as3.pcc.chessboard.view.views.game.ColorSettingsDialog;

import flash.net.getClassByAlias;

import org.puremvc.as3.interfaces.IMediator;
import org.puremvc.as3.interfaces.IMediator;
import org.puremvc.as3.interfaces.IMediator;
import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.observer.Notification;

/**
 * DialogActionCommand
 *
 * @author robin heinel
 */
public class DialogActionCommand extends BaseCommand {
	// Start SimpleCommand overrides

	public override function execute( n : INotification ) : void {
		super.execute( n );

		var stage : mainapp = appMediator.app;

		switch ( n.getName() ) {
			case ApplicationFacade.APPEAR_MOVE_HISTORY_MODIFIER:
				this.appearDialog( new MoveHistoryModifierMediator( stage ), n );
			break;
			case ApplicationFacade.PAWN_PROMOTION:
				this.appearDialog( new PawnConvertMediator( stage ), n );
			break;
			case ApplicationFacade.APPEAR_PIECE_SETTINGS:
				this.appearPieceSettings( new PieceSettingsMediator( stage ), n );
			break;
			case ApplicationFacade.APPEAR_COLOR_SETTINGS:
				this.appearColorSettings( new ColorSettingsMediator( stage ), n );
			break;
			case ApplicationFacade.APPEAR_BOARD_SETTINGS:
				this.appearBoardSettings( new BoardSettingsMediator( stage ), n );
			break;

			case ApplicationFacade.DISAPPEAR_MOVE_HISTORY_MODIFIER:
				this.closeDialog( MoveHistoryModifierMediator.NAME );
			break;
			case ApplicationFacade.DISAPPEAR_PIECE_SETTINGS:
				this.closeDialog( PieceSettingsMediator.NAME );
			break;
			case ApplicationFacade.DISAPPEAR_COLOR_SETTINGS:
				this.closeDialog( ColorSettingsMediator.NAME );
			break;
			case ApplicationFacade.DISAPPEAR_BOARD_SETTINGS:
				this.closeDialog( BoardSettingsMediator.NAME );
			break;

            case ApplicationFacade.APPEAR_MOVE_HISTORY_PANEL:
                this.appearMoveHistoryPanel( new MoveHistoryMediator( stage ), n );
            break;
            case ApplicationFacade.APPEAR_TAKEN_PIECES_PANEL:
                this.appearTakenPiecesPanel( new TakenPiecesMediator( stage ), n );
            break;

            case ApplicationFacade.DISAPPEAR_MOVE_HISTORY_PANEL:
                this.closeDialog( MoveHistoryMediator.NAME );
            break;
            case ApplicationFacade.DISAPPEAR_TAKEN_PIECES_PANEL:
                this.closeDialog( TakenPiecesMediator.NAME );
            break;
		}

		log.debug( LoggerUtil.outDictionary( appProxy.getOpenDialogs() ) );
	}

	// End SimpleCommand overrides


	// Start Innerclass Methods

	private function appearDialog( mediator : IMediator, n : INotification, handle : INotification = null ) : void {
		if ( this.facade.hasMediator( mediator.getMediatorName() ) || this.appProxy.isDialogOpen( mediator.getMediatorName() ) ) {
			n.setType( ApplicationFacade.NOTIFICATION_TYPE_INTERRUPT_APPEAR );
			return;
		}

		this.facade.registerMediator( mediator );

		if ( handle != null ) {
			mediator.handleNotification( handle )
		}

		mediator.handleNotification( n );
		appProxy.openDialog( mediator.getMediatorName() );
	}

    private function appearMoveHistoryPanel( mediator : MoveHistoryMediator, n : INotification ) : void {
        this.appearDialog( mediator, n );
    }

    private function appearTakenPiecesPanel( mediator: TakenPiecesMediator, n : INotification ) : void {
        this.appearDialog( mediator, n );
    }

	public function appearBoardSettings( mediator : IMediator, n : INotification ) : void {
		n.setBody( appProxy.board );
		this.appearDialog( mediator, n );
	}

	public function appearColorSettings( mediator : IMediator, n : INotification ) : void {
		var appear : ColorSettingsAppearVO = new ColorSettingsAppearVO();
		appear.colorThemes = appProxy.colorThemes;
		appear.currentColors = appProxy.colors;
		n.setBody( appear );
		this.appearDialog( mediator, n );
	}

	public function appearPieceSettings( mediator : IMediator, n : INotification ) : void {
		var sets : PieceSettingsVO = new PieceSettingsVO();
		sets.fonts = this.fontProxy.getFonts();
		sets.font = this.fontProxy.currentFont;
		sets.fontSize = this.fontProxy.currentFontSize;

		n.setBody( sets );
		this.appearDialog( mediator, n );
	}

	private function closeDialog( mediatorName : String ) : void {
		this.facade.removeMediator( mediatorName );
		appProxy.closeDialog( mediatorName );
	}

	// End Innerclass Methods


	// Start Getter / Setters

	private function get modifierMediator() : MoveHistoryModifierMediator {
		return this.facade.retrieveMediator( MoveHistoryModifierMediator.NAME ) as MoveHistoryModifierMediator;
	}

	private function get pieceSettingsMediator() : PieceSettingsMediator {
		return this.facade.retrieveMediator( PieceSettingsMediator.NAME ) as PieceSettingsMediator;
	}

	private function get colorSettingsMediator() : ColorSettingsMediator {
		return this.facade.retrieveMediator( ColorSettingsMediator.NAME ) as ColorSettingsMediator;
	}

	private function get fontProxy() : FontProxy {
		return this.facade.retrieveProxy( FontProxy.NAME ) as FontProxy;
	}

	// End Getter / Setters
}
}