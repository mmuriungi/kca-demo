page 52148 "CRM Segmentation Card"
{
    PageType = Card;
    Caption = 'Customer Segmentation Card';
    SourceTable = "CRM Segmentation";
    ApplicationArea = All;
    UsageCategory = None;
    
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique code for this segmentation.';
                }
                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description of the segmentation.';
                }
                field("Segmentation Type"; Rec."Segmentation Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of segmentation (Demographic, Geographic, Behavioral, etc.).';
                }
                field("Active"; Rec."Active")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether this segmentation is active.';
                }
            }
            
            group(Targeting)
            {
                Caption = 'Targeting';
                
                field("Target Audience"; Rec."Target Audience")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the target audience for this segmentation.';
                }
                field("Marketing Priority"; Rec."Marketing Priority")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the marketing priority level for this segmentation.';
                }
                field("Customer Count"; Rec."Customer Count")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows the number of customers that match this segmentation criteria.';
                    Editable = false;
                    Style = Strong;
                }
            }
            
            group("&Criteria")
            {
                Caption = 'Criteria';
                
                field("Criteria"; Rec."Criteria")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the criteria used to define this segmentation.';
                    MultiLine = true;
                }
                field("Notes"; Rec."Notes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies additional notes about this segmentation.';
                    MultiLine = true;
                }
            }
            
            group(Tracking)
            {
                Caption = 'Tracking';
                
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows when this segmentation was created.';
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows who created this segmentation.';
                    Editable = false;
                }
                field("Modified Date"; Rec."Modified Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows when this segmentation was last modified.';
                    Editable = false;
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows who last modified this segmentation.';
                    Editable = false;
                }
            }
        }
        
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }
    
    actions
    {
        area(processing)
        {
            action("Update Customer Count")
            {
                ApplicationArea = All;
                Caption = 'Update Customer Count';
                Image = Refresh;
                ToolTip = 'Refresh the customer count for this segmentation.';
                
                trigger OnAction()
                begin
                    Rec.CalcFields("Customer Count");
                    CurrPage.Update();
                end;
            }
            
            action("View Customers")
            {
                ApplicationArea = All;
                Caption = 'View Customers';
                Image = CustomerList;
                ToolTip = 'View the customers that belong to this segmentation.';
                
                trigger OnAction()
                var
                    CRMCustomer: Record "CRM Customer";
                begin
                    CRMCustomer.SetRange("Segmentation Code", Rec."Code");
                    Page.Run(Page::"CRM Customer List", CRMCustomer);
                end;
            }
        }
        
        area(navigation)
        {
            action("Customer List")
            {
                ApplicationArea = All;
                Caption = 'Customer List';
                Image = CustomerList;
                RunObject = Page "CRM Customer List";
                RunPageLink = "Segmentation Code" = field("Code");
                ToolTip = 'View the list of customers in this segmentation.';
            }
        }
        
        area(reporting)
        {
            action("Segmentation Report")
            {
                ApplicationArea = All;
                Caption = 'Segmentation Report';
                Image = Report;
                ToolTip = 'Generate a report for this segmentation.';
                
                trigger OnAction()
                var
                    CRMSegmentation: Record "CRM Segmentation";
                begin
                    CRMSegmentation.SetRange("Code", Rec."Code");
                    // Report.Run(Report::"CRM Segmentation Report", true, false, CRMSegmentation);
                    Message('Segmentation report functionality will be implemented.');
                end;
            }
        }
    }
}
