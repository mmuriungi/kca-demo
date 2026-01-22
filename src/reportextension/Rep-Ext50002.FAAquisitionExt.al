reportextension 50002 "FA Aquisition Ext" extends "Fixed Asset - Acquisition List"
{
    dataset
    {
        add("Fixed Asset")
        {
            column(Acquired; Acquired)
            {
            }
            column(PurchaseAmount; "Purchase Amount")
            {
            }
            column(DepreciationBook; FADepBook."Acquisition Cost")
            {
            }

        }

        modify("Fixed Asset")
        {
            trigger OnAfterAfterGetRecord()
            begin
                FADepBook.Reset();
                FADepBook.SetRange("FA No.", "Fixed Asset"."No.");
                if FADepBook.FindFirst() then
                    FADepBook.CalcFields("Acquisition Cost");
            end;
        }


    }
    var
        pg: page "Fixed Asset Card";
        FADepBook: Record "FA Depreciation Book";
}
