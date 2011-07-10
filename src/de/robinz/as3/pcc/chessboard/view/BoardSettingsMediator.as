package de.robinz.as3.pcc.chessboard.view {
import de.robinz.as3.pcc.chessboard.ApplicationFacade;
import de.robinz.as3.pcc.chessboard.library.vo.BoardSettingsVO;
import de.robinz.as3.pcc.chessboard.library.vo.ColorSettingsVO;
import de.robinz.as3.pcc.chessboard.library.vo.ColorSettingsVO;
import de.robinz.as3.pcc.chessboard.view.views.game.BoardSettingsDialog;
import de.robinz.as3.pcc.chessboard.view.views.game.ColorSettingsDialog;

import flash.events.Event;
import flash.events.MouseEvent;

import mx.containers.TitleWindow;
import mx.controls.Button;
import mx.controls.ColorPicker;
import mx.events.ColorPickerEvent;

import org.puremvc.as3.interfaces.INotification;

/**
 * BoardSettingsMediator
 *
 * @author robin heinel
 */
public class BoardSettingsMediator extends DialogBaseMediator {

	public static const NAME : String = "BoardSettingsMediator";

	private var _settings : BoardSettingsVO;

	public function BoardSettingsMediator( stage : mainapp ) {
		super( NAME, stage );
	}

	// Start Innerclass Methods

	private function appear() : void {
		var view : TitleWindow = this.createDialog( "Board Settings", 450, 325, BoardSettingsDialog, this.stage );

		view.addEventListener( MouseEvent.CLICK, onMouseClick );
		view.addEventListener( BoardSettingsDialog.EVENT_CLOSE, onClose );

		this._dialog = view as BoardSettingsDialog;
		this._dialog.addEventListener( MouseEvent.CLICK, onMouseClick );
	}

	private function close() : void {
		sendNotification( ApplicationFacade.DISAPPEAR_BOARD_SETTINGS );
		this.disappear();
	}

	private function applyChanges() : void {
		this._settings = new BoardSettingsVO();

		// TODO: check numeric type
		this._settings.size = int( this.popup.boardSize.text );
		this._settings.fixedSize = this.popup.fixedSize.selected;
		this._settings.verticalAlign = String( this.popup.boardVerticalAlign.value );
		this._settings.horizontalAlign = String( this.popup.boardHorizontalAlign.value );

		sendNotification( ApplicationFacade.CHANGE_BOARD_SETTINGS, this._settings );
	}

	// End Innerclass Methods


	// Start Object Methods

	// Start Object Methods


	// Start Notification Delegates

	public override function listNotificationInterests() : Array {
		return [
			ApplicationFacade.APPEAR_BOARD_SETTINGS,
			ApplicationFacade.DISAPPEAR_BOARD_SETTINGS
		];
	}

	public override function handleNotification( n : INotification ) : void {
		switch ( n.getName() ) {
			case ApplicationFacade.APPEAR_BOARD_SETTINGS:
				this.handleAppearBoardSettings( n.getType() is String ? n.getType() as String : null );
			break;
			case ApplicationFacade.DISAPPEAR_BOARD_SETTINGS:
				this.handleDisappearBoardSettings();
			break;

		}
	}

	// End Notification Delegates


	// Start Notification Handlers

	private function handleAppearBoardSettings( type : String ) : void {
		if ( type == ApplicationFacade.NOTIFICATION_TYPE_INTERRUPT_APPEAR ) {
			return;
		}

		this.appear();
	}

	private function handleDisappearBoardSettings() : void {
		this.disappear();
	}

	// End Notification Handlers


	// Start Event Handlers

	private function onClose( e : Event ) : void {
		this.close();
	}

	private function onMouseClick( e : MouseEvent ) : void {
		if ( e.target is Button ) {
			var b : Button = e.target as Button;
			if ( b.id == popup.applyChanges.id ) {
				this.applyChanges();
			}
		}
	}

	// End Event Handlers


	// Start Getter / Setters

	protected function get popup() : BoardSettingsDialog {
		return this._dialog as BoardSettingsDialog;
	}

	// End Getter / Setters

}
}