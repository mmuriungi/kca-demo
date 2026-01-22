page 52179036 "Audit Resource Allocation List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Audit Resource Allocation";
    Caption = 'Audit Resource Allocation';
    CardPageId = "Audit Resource Allocation Card";
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
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
                field("Allocation Status"; Rec."Allocation Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the allocation status.';
                }
                field("Total Cost"; Rec."Total Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total cost.';
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action("Allocate Resource")
            {
                ApplicationArea = All;
                Caption = 'Allocate Resource';
                Image = Allocate;
                ToolTip = 'Allocate a new resource to an audit.';
                
                trigger OnAction()
                var
                    ResourceAllocation: Record "Audit Resource Allocation";
                begin
                    ResourceAllocation.Init();
                    ResourceAllocation."Allocation Start Date" := Today;
                    ResourceAllocation."Allocation End Date" := CalcDate('<+1W>', Today);
                    ResourceAllocation.Insert(true);
                    CurrPage.Update();
                end;
            }
            action("Confirm Allocation")
            {
                ApplicationArea = All;
                Caption = 'Confirm Allocation';
                Image = Confirm;
                ToolTip = 'Confirm the selected allocation.';
                
                trigger OnAction()
                begin
                    if Rec."Allocation Status" = Rec."Allocation Status"::Planned then begin
                        Rec."Allocation Status" := Rec."Allocation Status"::Confirmed;
                        Rec.Modify();
                        CurrPage.Update();
                    end;
                end;
            }
            action("Resource Utilization")
            {
                ApplicationArea = All;
                Caption = 'Resource Utilization';
                Image = Statistics;
                ToolTip = 'View resource utilization statistics.';
                
                trigger OnAction()
                begin
                    Message('Resource utilization report will be implemented.');
                end;
            }
        }
        area(Navigation)
        {
            action("Related Audit")
            {
                ApplicationArea = All;
                Caption = 'Related Audit';
                Image = Navigate;
                ToolTip = 'Open the related audit record.';
                
                trigger OnAction()
                var
                    AuditHeader: Record "Audit Header";
                begin
                    if AuditHeader.Get(Rec."Audit No.") then
                        Page.Run(Page::"Audit Card", AuditHeader);
                end;
            }
        }
    }
}