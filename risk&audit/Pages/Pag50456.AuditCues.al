page 50103 "Audit Cues"
{
    Caption = 'Audit Management Cues';
    PageType = CardPart;
    SourceTable = "Common Activities Role Center";
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            cuegroup("Risk Management")
            {
                field("Risks Champion List"; "Risks Champion List")
                {
                    Caption = 'Risks Champion List';
                    ApplicationArea = All;
                    DrillDownPageId = "Risks List";
                }
                field("Risk Manager List"; "Risk Manager List")
                {
                    Caption = 'Risk Manager List';
                    ApplicationArea = All;
                    DrillDownPageId = "Risk Champion List";
                }
                field("Consolidated Risk List"; "Consolidated Risk List")
                {
                    Caption = 'Consolidated Risk List';
                    ApplicationArea = All;
                    DrillDownPageId = "Consolidated Risk List";
                }
              
                field("Approved Risk List"; "Approved Risk List")
                {
                    Caption = 'Approved Risk List';
                    ApplicationArea = All;
                    DrillDownPageId = "Approved Risk List";
                }

            }
            cuegroup("Audit Plan")
            {
                field("Audit Plan List"; "Audit Plan List")
                {
                    Caption = 'Audit Plan List';
                    ApplicationArea = All;
                    DrillDownPageId = "Audit Plan List";
                }
                field("Council Audit Plan List"; "Council Audit Plan List")
                {
                    Caption = 'Council Audit Plan List';
                    ApplicationArea = All;
                    DrillDownPageId = "Council Audit Plan List";
                }
                field("Audit Period"; "Audit Period")
                {
                    Caption = 'Audit Period';
                    ApplicationArea = All;
                    DrillDownPageId = "Audit Period";
                }

            }
            cuegroup("Audit Communications")
            {
                field("Audit Communication"; "Audit Communication")
                {
                    Caption = 'Audit Communication';
                    ApplicationArea = All;
                    DrillDownPageId = "Audit Communications";
                }
                // field("Sent Audit Communications"; "Sent Audit Communications")
                // {
                //     Caption = 'Sent Audit Communications';
                //     ApplicationArea = All;
                //     DrillDownPageId = "Sent Audit Communications";
                // }
                field("Audit Notifications"; "Audit Notifications")
                {
                    Caption = 'Audit Notifications';
                    ApplicationArea = All;
                    DrillDownPageId = "Audit Notifications";
                }
                field("Sent Audit Notifications"; "Sent Audit Notifications")
                {
                    Caption = 'Sent Audit Notifications';
                    ApplicationArea = All;
                    DrillDownPageId = "Sent Audit Notifications";
                }
                field("Audit Program List"; "Audit Program List")
                {
                    Caption = 'Audit Program List';
                    ApplicationArea = All;
                    DrillDownPageId = "Audit Program List";
                }
                field("Audit Work Papers"; "Audit Work Papers")
                {
                    Caption = 'Audit Work Papers';
                    ApplicationArea = All;
                    DrillDownPageId = "Audit Work Papers";
                }
                field("Audit Reports"; "Audit Reports")
                {
                    Caption = 'Audit Reports';
                    ApplicationArea = All;
                    DrillDownPageId = "Audit Reports";
                }

            }

        }

    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        RESET;
        IF NOT GET THEN BEGIN
            INIT;
            INSERT;
        END;
    end;

}

