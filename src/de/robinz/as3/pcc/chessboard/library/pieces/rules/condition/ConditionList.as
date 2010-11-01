package de.robinz.as3.pcc.chessboard.library.pieces.rules.condition
{
	import de.robinz.as3.rzlib.collections.TypedCollection;

	public class ConditionList extends TypedCollection
	{
		public function ConditionList() {
			super( ICondition, TypedCollection.COMPARISON_ISA );
		}


		public function getAt( index : int ) : ICondition {
			return ICondition( this._getAt( index ) );
		}

		public function removeAt( index : int ) : ICondition {
			return ICondition( this._removeAt( index ) );
		}

	}
}