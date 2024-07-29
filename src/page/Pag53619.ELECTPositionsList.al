page 53619 "ELECT-Positions List"
{
    CardPageID = "ELECT-Positions Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "ELECT-Positions";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Position Code"; Rec."Position Code")
                {
                    ApplicationArea = All;
                }
                field("Position Description"; Rec."Position Description")
                {
                    ApplicationArea = All;
                }
                field("Position Notes"; Rec."Position Notes")
                {
                    ApplicationArea = All;
                }
                field("Electral District"; Rec."Electral District")
                {
                    ApplicationArea = All;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                }
                field("No. Of Candidates"; Rec."No. Of Candidates")
                {
                    ApplicationArea = All;
                }
                field("Position Approved"; Rec."Position Approved")
                {
                    ApplicationArea = All;
                }
                field("School Code"; Rec."School Code")
                {
                    ApplicationArea = All;
                }
                field("Campus Code"; Rec."Campus Code")
                {
                    ApplicationArea = All;
                }
                field("Position Category"; Rec."Position Category")
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
            action("Candidature Applications")
            {
                Caption = 'Candidature Applications';
                Image = ApplyTemplate;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "ELECT-Cand. Applications List";
                RunPageLink = "Election Code" = FIELD("Election Code"),
                              "Position Code" = FIELD("Position Code"),
                              "Position Category" = FIELD("Position Category");
                ApplicationArea = All;
            }
            action(Candidates)
            {
                Caption = 'Candidates';
                Image = Hierarchy;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "ELECT-Candidates List";
                RunPageLink = "Election Code" = FIELD("Election Code"),
                              "Position Code" = FIELD("Position Code"),
                              "Position Category" = FIELD("Position Category");
                ApplicationArea = All;
            }
            action(Ballots)
            {
                Caption = 'Ballots';
                Image = RegisterPick;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "ELECT-Ballot Register List";
                RunPageLink = "Election Code" = FIELD("Election Code"),
                              "Position Code" = FIELD("Position Code");
                ApplicationArea = All;
            }
        }
    }
}

