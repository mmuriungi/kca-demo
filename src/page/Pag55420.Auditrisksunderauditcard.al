page 55420 "Audit-  risks under audit card"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "AUDIT-Risk Analysis Header";

    layout
    {
        area(content)
        {
            group(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Departmant Name"; Rec."Departmant Name")
                {
                    ApplicationArea = All;
                }
                field(Likelihood; Rec.Likelihood)
                {
                    ApplicationArea = All;
                }
                field(Impact; Rec.Impact)
                {
                    ApplicationArea = All;
                }
                field("Overall Rating"; Rec."Overall Rating")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Responsible Persons"; Rec."Responsible Persons")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("Risk Processes")
            {
                Caption = '&Risk Processes';
                action(Causes)
                {
                    Image = LotInfo;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Audit Risk Caues Lines";
                    RunPageLink = "Risk Code" = FIELD(No);
                    ApplicationArea = All;
                }
                action(Impacts)
                {
                    Image = Allocate;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Audit Risk Impacts Lines";
                    RunPageLink = "Risk Code" = FIELD(No);
                    ApplicationArea = All;
                }
                action("Risk Actions")
                {
                    Image = Answers;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Audit Risk Actions lines";
                    RunPageLink = "Risk Code" = FIELD(No);
                    ApplicationArea = All;
                }
            }
            separator("&Submit")
            {
                Caption = '&Submit';
            }
            action(Reopen)
            {
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Category4;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF Rec.status = Rec.status::"In Audit" THEN BEGIN
                        Rec.status := Rec.status::Reopened;
                        Rec.MODIFY;
                    END;
                end;
            }
        }
    }
}

