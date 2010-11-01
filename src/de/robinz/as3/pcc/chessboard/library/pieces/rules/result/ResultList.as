package de.robinz.as3.pcc.chessboard.library.pieces.rules.result
{
	import de.robinz.as3.rzlib.collections.TypedCollection;

	public class ResultList extends TypedCollection
	{
		public function ResultList() {
			super( IResult, TypedCollection.COMPARISON_ISA );
		}


		public function getAt( index : int ) : IResult {
			return IResult( this._getAt( index ) );
		}

		public function removeAt( index : int ) : IResult {
			return IResult( this._removeAt( index ) );
		}

	}
}