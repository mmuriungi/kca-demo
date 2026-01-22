page 52179023 "CRM Segmentation List"
{
    PageType = List;
    Caption = 'Customer Segmentation';
    SourceTable = "CRM Segmentation";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the segmentation code.';
                }
                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description of this customer segmentation.';
                }
                field("Segmentation Type"; Rec."Segmentation Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of segmentation criteria.';
                }
                field("Target Audience"; Rec."Target Audience")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the target customer type for this segment.';
                }
                field("Marketing Priority"; Rec."Marketing Priority")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the marketing priority level for this segment.';
                }
                field("Customer Count"; Rec."Customer Count")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows the number of customers in this segment.';
                    StyleExpr = CustomerCountStyle;
                }
                field("Active"; Rec."Active")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether this segmentation is active.';
                }
                field("Criteria"; Rec."Criteria")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the criteria used for this segmentation.';
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows when this segmentation was created.';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows who created this segmentation.';
                }
            }
        }
        area(factboxes)
        {
            part("Segmentation Statistics"; "CRM Dashboard FactBox")
            {
                ApplicationArea = All;
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
                    CurrPage.Update(false);
                    Message('Customer count updated. Current count: %1', Rec."Customer Count");
                end;
            }
            
            action("Apply Segmentation")
            {
                ApplicationArea = All;
                Caption = 'Apply Segmentation';
                Image = Apply;
                ToolTip = 'Apply this segmentation to eligible customers.';
                
                trigger OnAction()
                begin
                    if Confirm('Apply segmentation "%1" to eligible customers?', true, Rec.Description) then begin
                        ApplySegmentationToCustomers();
                        Message('Segmentation applied successfully.');
                    end;
                end;
            }
            
            action("View Customers")
            {
                ApplicationArea = All;
                Caption = 'View Customers';
                Image = Customer;
                ToolTip = 'View customers in this segment.';
                
                trigger OnAction()
                var
                    CRMCustomer: Record "CRM Customer";
                begin
                    CRMCustomer.SetRange("Segmentation Code", Rec.Code);
                    Page.Run(Page::"CRM Customer List", CRMCustomer);
                end;
            }
        }
        
        area(creation)
        {
            action("New Segmentation")
            {
                ApplicationArea = All;
                Caption = 'New Segmentation';
                Image = New;
                ToolTip = 'Create a new customer segmentation.';
                RunObject = Page "CRM Segmentation Card";
                RunPageMode = Create;
            }
        }
        
        area(reporting)
        {
            action("Segmentation Analysis")
            {
                ApplicationArea = All;
                Caption = 'Segmentation Analysis';
                Image = Report;
                ToolTip = 'Generate segmentation analysis report.';
                
                trigger OnAction()
                begin
                    Message('Segmentation analysis report would be generated here.');
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetCustomerCountStyle();
    end;

    local procedure ApplySegmentationToCustomers()
    var
        CRMCustomer: Record "CRM Customer";
    begin
        // This would contain logic to apply segmentation criteria to customers
        // For now, it's a placeholder
        CRMCustomer.SetRange("Segmentation Code", '');
        if CRMCustomer.FindSet() then
            repeat
                // Apply segmentation logic here based on criteria
                CRMCustomer."Segmentation Code" := Rec.Code;
                CRMCustomer.Modify();
            until CRMCustomer.Next() = 0;
    end;

    local procedure SetCustomerCountStyle()
    begin
        Rec.CalcFields("Customer Count");
        case Rec."Customer Count" of
            0:
                CustomerCountStyle := 'Unfavorable';
            1 .. 50:
                CustomerCountStyle := 'Standard';
            51 .. 200:
                CustomerCountStyle := 'Favorable';
            else
                CustomerCountStyle := 'Strong';
        end;
    end;

    var
        CustomerCountStyle: Text;
}