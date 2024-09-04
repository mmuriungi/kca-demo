page 52025 "Contract Committee"
{

    Caption = 'Contract Extension Committee Lines';
    PageType = ListPart;
    SourceTable = "Contract Committee";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document No"; Rec."Document No")
                {
                    ToolTip = 'Specifies the value of the Document No field.';
                    ApplicationArea = All;
                }
                field(No; rec.No)
                {
                    ToolTip = 'Specifies the value of the Employee No field.';
                    ApplicationArea = All;
                    Caption = 'Employee No';
                }

                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                    ApplicationArea = All;
                }
                field(Title; Rec.Title)
                {
                    ToolTip = 'Specifies the value of the Title field.';
                    ApplicationArea = All;
                }
                field("Acceptance Status"; Rec."Acceptance Status")
                {
                    ToolTip = 'Specifies the value of the Acceptance Status field.';
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies the value of the Comment field.';
                    ApplicationArea = All;
                }
            }
        }
    }

}
