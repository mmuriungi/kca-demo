page 54217 "Motor Vehicle CheckList Card"
{
    PageType = Card;
    SourceTable = "Motor Vehicle Checklists";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Vehicle Reg No."; Rec."Vehicle Reg No.")
                {
                    ApplicationArea = All;
                }
                field("Vehicle Name"; Rec."Vehicle Name")
                {
                    ApplicationArea = All;
                }
                field("Mileage Reading"; Rec."Mileage Reading")
                {
                    ApplicationArea = All;
                }
                field("Type Of Vehicle"; Rec."Type Of Vehicle")
                {
                    ApplicationArea = All;
                }
                field(Item; Rec.Item)
                {
                    ApplicationArea = All;
                }
                field(Contition; Rec.Contition)
                {
                    OptionCaption = '<,Good ,Bad>';
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Name Of Receiving Driver"; Rec."Name Of Receiving Driver")
                {
                    ApplicationArea = All;
                }
                field("Name Of Handing Over Driver"; Rec."Name Of Handing Over Driver")
                {
                    ApplicationArea = All;
                }
                field("Admin officer"; Rec."Admin officer")
                {
                    ApplicationArea = All;
                }
                field(Departments; Rec.Departments)
                {
                    ApplicationArea = All;
                }
            }
            part("Motor Vehicle Checklist Line"; "Motor Vehicle Checklist Line")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Printing)
            {
                ApplicationArea = All;
            }
            action(Print)
            {
                Image = ActivateDiscounts;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin

                    Rec.RESET;
                    Rec.SETFILTER("No.", Rec."No.");
                    //REPORT.RUN(39005544,TRUE,TRUE,Rec);
                    Rec.RESET;
                end;
            }
        }
    }
}

