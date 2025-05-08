page 53102 "Medical Claims Subform"
{
    ApplicationArea = All;
    Caption = 'Medical Claims';
    PageType = ListPart;
    SourceTable = "HRM-Medical Claims";
    CardPageId = "Medical Claims Card";
    InsertAllowed = false;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
               
                field("Claim No"; Rec."Claim No")
                {
                    ApplicationArea = All;
                }
                field("Claim Date"; Rec."Claim Date")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Claim Type"; Rec."Claim Type")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                }
                field("Document Ref"; Rec."Document Ref")
                {
                    ApplicationArea = All;
                }
                field("Patient Type"; Rec."Patient Type")
                {
                    ApplicationArea = All;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                }
                field("Member Names"; Rec."Member Names")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Scheme No"; Rec."Scheme No")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                }
                field("Scheme Name"; Rec."Scheme Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
         
                field(Dependants; Rec.Dependants)
                {
                    ApplicationArea = All;
                    Importance = Standard;
                }
                field("Patient Name"; Rec."Patient Name")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                }
          
                field("Facility Attended"; Rec."Facility Attended")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                }
                field("Facility Name"; Rec."Facility Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Date of Service"; Rec."Date of Service")
                {
                    ApplicationArea = All;
                }
          
                field("Claim Currency Code"; Rec."Claim Currency Code")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                }
                field("Claim Amount"; Rec."Claim Amount")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Currency Factor"; Rec."Currency Factor")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Scheme Currency Code"; Rec."Scheme Currency Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Scheme Amount Charged"; Rec."Scheme Amount Charged")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
          
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }

            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(ViewClaim)
            {
                ApplicationArea = All;
                Caption = 'View Claim';
                Image = View;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'View the medical claim details';
                
                trigger OnAction()
                begin
                    Page.RunModal(Page::"Medical Claims Card", Rec);
                end;
            }
        }
    }
}
