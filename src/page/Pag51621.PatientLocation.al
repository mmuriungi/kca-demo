page 51621 "Patient Location"
{
    Caption = ' Patient Location ';
    PageType = List;
    SourceTable = "HMS-Treatment Form Header";
    SourceTableView = where(Location = filter(<> " "));

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Treatment No."; Rec."Treatment No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Treatment No. field.';
                }
                field("Treatment Date"; Rec."Treatment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Student No. field.';
                }

                field("Patient No."; Rec."Patient No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Patient No. field.', Comment = '%';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee No. field.';
                }
                field("Treatment Remarks"; Rec."Treatment Remarks")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Treatment Remarks field.', Comment = '%';
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Location field.', Comment = '%';
                }
                field("Doctor ID"; Rec."Doctor ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Doctor ID field.', Comment = '%';
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Email field.';
                }
                field("Patient Name"; Rec."Patient Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Last Name field.';
                }
            }
        }
    }
}
