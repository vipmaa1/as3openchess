package de.robinz.as3.pcc.chessboard.library.pieces.rules
{
	import de.robinz.as3.rzlib.collections.TypedCollection;

	public class RuleList extends TypedCollection
	{
		public function RuleList() {
			super( IResult, TypedCollection.COMPARISON_ISA );
		}

		public function getAt( index : int ) : IRule {
			return IRule( this._getAt( index ) );
		}

		public function removeAt( index : int ) : IRule {
			return IRule( this._removeAt( index ) );
		}

	}
}