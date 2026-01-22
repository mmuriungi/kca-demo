page 52149 "CRM Customer Statistics"
{
    PageType = CardPart;
    SourceTable = "CRM Customer";
    Caption = 'Customer Statistics';

    layout
    {
        area(content)
        {
            group("Statistics")
            {
                Caption = 'Statistics';
                
                field("Total Sales Amount"; TotalSalesAmount)
                {
                    ApplicationArea = All;
                    Caption = 'Total Sales Amount';
                    Editable = false;
                    ToolTip = 'Shows the total sales amount for this customer';
                }
                
                field("Number of Orders"; NumberOfOrders)
                {
                    ApplicationArea = All;
                    Caption = 'Number of Orders';
                    Editable = false;
                    ToolTip = 'Shows the total number of orders for this customer';
                }
                
                field("Last Order Date"; LastOrderDate)
                {
                    ApplicationArea = All;
                    Caption = 'Last Order Date';
                    Editable = false;
                    ToolTip = 'Shows the date of the last order for this customer';
                }
                
                field("Average Order Value"; AverageOrderValue)
                {
                    ApplicationArea = All;
                    Caption = 'Average Order Value';
                    Editable = false;
                    ToolTip = 'Shows the average order value for this customer';
                }
                
                field("Customer Since"; CustomerSince)
                {
                    ApplicationArea = All;
                    Caption = 'Customer Since';
                    Editable = false;
                    ToolTip = 'Shows when this customer was first created';
                }
                
                field("Days Since Last Contact"; DaysSinceLastContact)
                {
                    ApplicationArea = All;
                    Caption = 'Days Since Last Contact';
                    Editable = false;
                    ToolTip = 'Shows the number of days since last contact with this customer';
                }
            }
            
            group("Interactions")
            {
                Caption = 'Interaction Summary';
                
                field("Total Interactions"; TotalInteractions)
                {
                    ApplicationArea = All;
                    Caption = 'Total Interactions';
                    Editable = false;
                    ToolTip = 'Shows the total number of interactions with this customer';
                }
                
                field("Last Interaction Date"; LastInteractionDate)
                {
                    ApplicationArea = All;
                    Caption = 'Last Interaction';
                    Editable = false;
                    ToolTip = 'Shows the date of the last interaction with this customer';
                }
                
                field("Preferred Contact Method"; PreferredContactMethod)
                {
                    ApplicationArea = All;
                    Caption = 'Preferred Contact';
                    Editable = false;
                    ToolTip = 'Shows the preferred contact method for this customer';
                }
            }
        }
    }

    var
        TotalSalesAmount: Decimal;
        NumberOfOrders: Integer;
        LastOrderDate: Date;
        AverageOrderValue: Decimal;
        CustomerSince: Date;
        DaysSinceLastContact: Integer;
        TotalInteractions: Integer;
        LastInteractionDate: Date;
        PreferredContactMethod: Text[50];

    trigger OnAfterGetRecord()
    begin
        CalculateStatistics();
    end;

    local procedure CalculateStatistics()
    var
        CRMInteraction: Record "CRM Interaction Log";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
    begin
        // Initialize variables
        TotalSalesAmount := 0;
        NumberOfOrders := 0;
        LastOrderDate := 0D;
        AverageOrderValue := 0;
        TotalInteractions := 0;
        LastInteractionDate := 0D;
        PreferredContactMethod := '';
        
        // Calculate customer since date
        CustomerSince := DT2Date(Rec."Created Date");
        
        // Calculate sales statistics (this would need to be adapted based on your sales table structure)
        // For now, using placeholder logic
        
        // Calculate interaction statistics
        CRMInteraction.SetRange("Customer No.", Rec."No.");
        TotalInteractions := CRMInteraction.Count();
        
        if CRMInteraction.FindLast() then begin
            LastInteractionDate := CRMInteraction."Interaction Date";
            if LastInteractionDate <> 0D then
                DaysSinceLastContact := Today - LastInteractionDate
            else
                DaysSinceLastContact := 0;
        end;
        
        // Set preferred contact method based on most used method
        CRMInteraction.SetRange("Customer No.", Rec."No.");
        if CRMInteraction.FindFirst() then
            PreferredContactMethod := Format(CRMInteraction."Contact Method");
    end;
}
