pageextension 50036 "Cash Receipt Journal Ext" extends "Cash Receipt Journal"
{
    layout
    {
        modify("External Document No.")
        {
            ApplicationArea = All;
            Visible = true;
            Editable = true;
        }
    }
}
