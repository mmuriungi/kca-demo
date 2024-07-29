page 54828 "HMS-Appointment List"
{
    CardPageID = "HMS-Appointment Form Header";
    PageType = List;
    SourceTable = "HMS-Appointment Form Header";
    SourceTableView = WHERE("Treatment Status" = FILTER(<> Completed));

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                Editable = false;
                field("Appointment No."; Rec."Appointment No.")
                {
                    ApplicationArea = All;
                }
                field("Appointment Date"; Rec."Appointment Date")
                {
                    ApplicationArea = All;
                }
                field("Appointment Time"; Rec."Appointment Time")
                {
                    ApplicationArea = All;
                }
                field("Appointment Type"; Rec."Appointment Type")
                {
                    ApplicationArea = All;
                }
                field("Patient Type"; Rec."Patient Type")
                {
                    ApplicationArea = All;
                }
                field("Patient No."; Rec."Patient No.")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                }
                field("Relative No."; Rec."Relative No.")
                {
                    ApplicationArea = All;
                }
                field(Doctor; Rec.Doctor)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        CurrPage.LOOKUPMODE := TRUE;
    end;
}

