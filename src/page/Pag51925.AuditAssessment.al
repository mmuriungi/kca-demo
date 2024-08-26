page 51925 "Audit Assessment"
{
    CardPageID = "Audit Assessment Card";
    PageType = List;
    SourceTable = "Audit Asssessment Header";
    SourceTableView = WHERE(Status = FILTER(Open | 'Re-Opened'));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                /* field(Department; Department)
                {
                } */
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                }
                field(Scope; Rec.Scope)
                {
                    ApplicationArea = All;
                }
                field(Process; Rec.Process)
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Assessment Start Date"; Rec."Assessment Start Date")
                {
                    ApplicationArea = All;
                }
                field("Assessment End Date"; Rec."Assessment End Date")
                {
                    ApplicationArea = All;
                }
                /* field(Asessor; Asessor)
                {
                } */
                field("Assessor Name"; Rec."Assessor Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Audit Evaluation Report")
            {
                Image = "Report";
                Promoted = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.RESET;
                    Rec.SETRANGE(No, Rec.No);
                    IF Rec.FINDFIRST THEN BEGIN
                        REPORT.RUN(99980, TRUE, FALSE, Rec);
                    END;
                    Rec.RESET;
                end;
            }
        }
    }
}

