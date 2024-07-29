page 54263 "Visitors List"
{
    CardPageID = "Visitors Card";
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Visitor Card";
    Caption = 'Visitors List';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = All;
                }
                field("Full Names"; Rec."Full Names")
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                }
                field("Company Name"; Rec."Company Name")
                {
                    ApplicationArea = All;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                }
                field("Vehicle Registration Number"; Rec."Vehicle Registration Number")
                {
                    ApplicationArea = All;

                }
                field("Reg. Date"; Rec."Reg. Date")
                {
                    ApplicationArea = All;
                }
                field("Reg. Time"; Rec."Reg. Time")
                {
                    ApplicationArea = All;
                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = All;
                }
                field("Registered By"; Rec."Registered By")
                {
                    ApplicationArea = All;
                }
                field("No. of Visits"; Rec."No. of Visits")
                {
                    ApplicationArea = All;
                }
                field("Date Filter"; Rec."Date Filter")
                {
                    ApplicationArea = All;
                }
                field("Time Filter"; Rec."Time Filter")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(Reports)
            {
                Caption = 'Statements';
                action("Statement (Summary)")
                {
                    Caption = 'Statement (Summary)';
                    Image = Report2;
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        visCard.RESET;
                        visCard.SETRANGE("ID No.", Rec."ID No.");
                        IF visCard.FIND('-') THEN BEGIN
                            REPORT.RUN(50052, TRUE, FALSE, visCard);
                        END;
                    end;
                }
                action("Statement (Detailed)")
                {
                    Caption = 'Statement (Detailed)';
                    Image = Report2;
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        visCard.RESET;
                        visCard.SETRANGE("ID No.", Rec."ID No.");
                        IF visCard.FIND('-') THEN BEGIN
                            REPORT.RUN(50053, TRUE, FALSE, visCard);
                        END;
                    end;
                }
            }
        }
    }

    var
        visCard: Record "Visitor Card";
}

