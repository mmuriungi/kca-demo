page 52092 "Research Publications"
{
    Caption = 'Research Publications';
    PageType = ListPart;
    SourceTable = "Research Publications";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No field.';
                }
                field(Authors; Rec.Authors)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Authors field.';
                }
                field("Journal Published"; Rec."Journal Published")
                {
                    ApplicationArea = All;
                    Caption = 'Link for publication';
                    ToolTip = 'Specifies the value of the Journal Published field.';
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Title of Publication"; Rec."Title of Publication")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Title of Publication field.';
                }
            }
        }
    }
}
