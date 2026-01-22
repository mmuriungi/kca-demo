page 52179037 "Audit Resource Allocation Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "Audit Resource Allocation";
    Caption = 'Audit Resource Allocation Card';
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                
                field("Allocation No."; Rec."Allocation No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the allocation number.';
                }
                field("Audit No."; Rec."Audit No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the audit number.';
                }
                field("Resource Type"; Rec."Resource Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the resource type.';
                }
                field("Resource Code"; Rec."Resource Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the resource code.';
                }
                field("Resource Name"; Rec."Resource Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the resource name.';
                }
                field("Allocation Status"; Rec."Allocation Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the allocation status.';
                }
            }
            
            group(Allocation)
            {
                Caption = 'Allocation Details';
                
                field("Allocation Start Date"; Rec."Allocation Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the allocation start date.';
                }
                field("Allocation End Date"; Rec."Allocation End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the allocation end date.';
                }
                field("Allocated Hours"; Rec."Allocated Hours")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the allocated hours.';
                }
                field("Actual Hours"; Rec."Actual Hours")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the actual hours.';
                }
                field("Utilization %"; Rec."Utilization %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the utilization percentage.';
                }
            }
            
            group(Costing)
            {
                Caption = 'Cost Information';
                
                field("Cost Rate"; Rec."Cost Rate")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the cost rate.';
                }
                field("Total Cost"; Rec."Total Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total cost.';
                }
                field("Actual Cost"; Rec."Actual Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the actual cost.';
                }
            }
            
            group(Additional)
            {
                Caption = 'Additional Information';
                
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the department code.';
                }
                field("Skill Required"; Rec."Skill Required")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the skill required.';
                }
                field("Comments"; Rec."Comments")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies any comments.';
                    MultiLine = true;
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action("Confirm Allocation")
            {
                ApplicationArea = All;
                Caption = 'Confirm Allocation';
                Image = Confirm;
                ToolTip = 'Confirm this resource allocation.';
                
                trigger OnAction()
                begin
                    if Rec."Allocation Status" = Rec."Allocation Status"::Planned then begin
                        Rec."Allocation Status" := Rec."Allocation Status"::Confirmed;
                        Rec.Modify();
                        CurrPage.Update();
                    end;
                end;
            }
            action("Activate Allocation")
            {
                ApplicationArea = All;
                Caption = 'Activate Allocation';
                Image = Start;
                ToolTip = 'Activate this resource allocation.';
                
                trigger OnAction()
                begin
                    if Rec."Allocation Status" = Rec."Allocation Status"::Confirmed then begin
                        Rec."Allocation Status" := Rec."Allocation Status"::Active;
                        Rec.Modify();
                        CurrPage.Update();
                    end;
                end;
            }
        }
    }
}