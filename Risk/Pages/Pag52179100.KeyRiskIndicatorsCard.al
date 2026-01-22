page 52179100 "Key Risk Indicators Card"
{
    PageType = Card;
    SourceTable = "Key Risk Indicators";
    Caption = 'Key Risk Indicators Card';
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General Information';
                
                field("KRI ID"; Rec."KRI ID")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("KRI Name"; Rec."KRI Name")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Related Risk ID"; Rec."Related Risk ID")
                {
                    ApplicationArea = All;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                }
            }
            
            group(Measurement)
            {
                Caption = 'Measurement Configuration';
                
                field("Measurement Method"; Rec."Measurement Method")
                {
                    ApplicationArea = All;
                }
                field("Data Source"; Rec."Data Source")
                {
                    ApplicationArea = All;
                }
                field("Monitoring Frequency"; Rec."Monitoring Frequency")
                {
                    ApplicationArea = All;
                }
            }
            
            group(Thresholds)
            {
                Caption = 'Performance Thresholds';
                
                field("Current Value"; Rec."Current Value")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Target Value"; Rec."Target Value")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Threshold - Green"; Rec."Threshold - Green")
                {
                    ApplicationArea = All;
                }
                field("Threshold - Yellow"; Rec."Threshold - Yellow")
                {
                    ApplicationArea = All;
                }
                field("Threshold - Red"; Rec."Threshold - Red")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
            }
            
            group(Status)
            {
                Caption = 'Status & Tracking';
                
                field("Alert Status"; Rec."Alert Status")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Last Measured Date"; Rec."Last Measured Date")
                {
                    ApplicationArea = All;
                }
                field("Next Measurement Date"; Rec."Next Measurement Date")
                {
                    ApplicationArea = All;
                }
                field(Active; Rec.Active)
                {
                    ApplicationArea = All;
                }
            }
            
            group(Responsibility)
            {
                Caption = 'Responsibility';
                
                field("Responsible Person"; Rec."Responsible Person")
                {
                    ApplicationArea = All;
                }
            }
            
            group(Administration)
            {
                Caption = 'Administration';
                
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Modified Date"; Rec."Modified Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(RecordMeasurement)
            {
                ApplicationArea = All;
                Caption = 'Record Measurement';
                Image = UpdateDescription;
                Promoted = true;
                PromotedCategory = Process;
                
                trigger OnAction()
                begin
                    Rec."Last Measured Date" := WorkDate();
                    Rec.Modify();
                    Message('Measurement recorded successfully.');
                end;
            }
        }
        
        area(Navigation)
        {
            action(ViewRisk)
            {
                ApplicationArea = All;
                Caption = 'View Related Risk';
                Image = View;
                RunObject = page "Risk Register Card";
                RunPageLink = "Risk ID" = field("Related Risk ID");
                Enabled = Rec."Related Risk ID" <> '';
            }
        }
    }
}