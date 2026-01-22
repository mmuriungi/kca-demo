page 52178537 "Proc-Preliminary Qualif"
{
    Caption = 'Preliminary Qualifications';
    PageType = ListPart;
    SourceTable = "Proc-Preliminary Qualif";
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Mandatory; Rec.Mandatory)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mandatory field.';
                }

            }

        }
    }
}