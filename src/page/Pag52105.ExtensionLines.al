page 52105 ExtensionLines
{
    Caption = 'ExtensionLines';
    PageType = ListPart;
    SourceTable = "Trainning Facilittaor";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Staff ID"; Rec."Staff ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Staff ID field.', Comment = '%';
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Staff Name field.', Comment = '%';
                }
            }
        }
    }
}
