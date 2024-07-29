page 50119 "PROC-Procurement Plan Header"
{
    PageType = Card;
    SourceTable = "PROC-Procurement Plan Header";

    layout
    {

        area(content)
        {

            group(General)
            {
                Caption = 'General';
                field("Budget Name"; Rec."Budget Name")
                {
                }
                field("Department Code"; Rec."Department Code")
                {
                }
                field("Schools"; Rec.Schools)
                {
                }
                field("Campus Code"; Rec."Campus Code")
                {

                    trigger OnValidate()
                    begin
                        Dim.RESET;
                        Dim.SETRANGE(Dim.Code, Rec."Department Code");
                        IF Dim.FIND('-') THEN BEGIN
                            DptName := Dim.Name;
                        END;
                    end;
                }
                field(DptName; DptName)
                {
                    Editable = false;
                }
                field("Procurement Plan Period"; Rec."Procurement Plan Period")
                {
                    Visible = false;
                }
            }
            part(part; "Workplan Activities")
            {
                SubPageLink = "WorkPlan Code" = FIELD("Budget Name"),
                               "Shortcut Dimension 2 Code" = FIELD("Department Code"),
                              "Global Dimension 1 Code" = FIELD("Campus Code");
            }
        }
    }

    actions
    {
        area(Reporting)
        {
            action(Print)
            {
                Caption = 'Print Plan';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = report "Procurement Plan";

                /* trigger OnAction()
                begin
                    Rec.RESET();
                    Rec.SETRANGE("Budget Name", Rec."Budget Name");
                    REPORT.RUN(52178711, TRUE, TRUE, Rec);
                    Rec.RESET;
                    //DocPrint.PrintPurchHeader(Rec);
                end */
                ;
            }
        }
    }

    var
        DptName: Text[50];
        Dim: Record 349;
}

