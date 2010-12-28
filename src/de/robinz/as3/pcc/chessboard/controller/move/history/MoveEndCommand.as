package de.robinz.as3.pcc.chessboard.controller.move.history
{
	import de.robinz.as3.pcc.chessboard.ApplicationFacade;
	import de.robinz.as3.pcc.chessboard.model.GameProxy;

	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	/**
	 * MoveEndCommand
	 *
	 * @author robin heinel
	 */
	public class MoveEndCommand extends SimpleCommand
	{
		// Start SimpleCommand overrides

		public override function execute( n : INotification ) : void {
			this.moveEnd();
		}

		// End SimpleCommand overrides


		// Start Innerclass Methods

		private function moveEnd() : void {
			// move forward until no moves left
			var i : int = 0;
			for( i; i <= this.gameProxy.getCurrentGame().moves.length; i++ ) {
				sendNotification( ApplicationFacade.MOVE_FORWARD );
			}
		}

		// End Innerclass Methods


		// Start Getter / Setters

		private function get gameProxy() : GameProxy {
			return this.facade.retrieveProxy( GameProxy.NAME ) as GameProxy;
		}

		// End Getter / Setters





	}
}