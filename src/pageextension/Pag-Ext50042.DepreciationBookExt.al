pageextension 50042 "Depreciation Book Ext" extends "FA Depreciation Books"
{
    layout
    {
        modify("Straight-Line %")
        {
            ApplicationArea = All;
            Visible = true;
        }
        
    }
}
