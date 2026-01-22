page 50136 "PROC-Vendor Classifications"
{
    PageType = List;
    SourceTable = "PROC-Vendor Classifications";
    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("PreQualification Code"; Rec."PreQualification Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the PreQualification Code field.';
                }
                field("Prequalification Description"; Rec."Prequalification Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prequalification Description field.';
                }
            }
        }
    }
}