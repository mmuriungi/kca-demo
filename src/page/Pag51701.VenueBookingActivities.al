page 50088 "Venue Booking Activities"
{
    Caption = 'Venue Booking Activities';
    PageType = CardPart;
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            cuegroup("Venue Bookings")
            {
                Caption = 'Venue Bookings';
                
                field(NewBookings; NewBookingsCount)
                {
                    Caption = 'New Bookings';
                    ApplicationArea = All;
                    DrillDownPageId = "Venue Booking List";
                    
                    trigger OnDrillDown()
                    var
                        VenueBooking: Record "Gen-Venue Booking";
                    begin
                        VenueBooking.Reset();
                        VenueBooking.SetRange(Status, VenueBooking.Status::New);
                        VenueBooking.SetRange("Requested By", UserId);
                        Page.Run(Page::"Venue Booking List", VenueBooking);
                    end;
                }
                
                field(PendingApproval; PendingApprovalCount)
                {
                    Caption = 'Pending Approval';
                    ApplicationArea = All;
                    DrillDownPageId = "Venue Booking - Pending Alloc.";
                    
                    trigger OnDrillDown()
                    var
                        VenueBooking: Record "Gen-Venue Booking";
                    begin
                        // VenueBooking.Reset();
                        // VenueBooking.SetRange(Status, VenueBooking.Status::"Pending Approval");
                        // Page.Run(Page::"Venue Booking Pending Alloc.", VenueBooking);
                    end;
                }
                
                field(ApprovedBookings; ApprovedBookingsCount)
                {
                    Caption = 'Approved Bookings';
                    ApplicationArea = All;
                    DrillDownPageId = "Venue Booking Allocated";
                    
                    trigger OnDrillDown()
                    var
                        VenueBooking: Record "Gen-Venue Booking";
                    begin
                        VenueBooking.Reset();
                        VenueBooking.SetRange(Status, VenueBooking.Status::Approved);
                        Page.Run(Page::"Venue Booking Allocated", VenueBooking);
                    end;
                }
                
                field(RejectedBookings; RejectedBookingsCount)
                {
                    Caption = 'Rejected Bookings';
                    ApplicationArea = All;
                    
                    trigger OnDrillDown()
                    var
                        VenueBooking: Record "Gen-Venue Booking";
                    begin
                        VenueBooking.Reset();
                        VenueBooking.SetRange(Status, VenueBooking.Status::Rejected);
                        Page.Run(Page::"Venue Booking List", VenueBooking);
                    end;
                }
            }
            
            cuegroup("Venue Management")
            {
                Caption = 'Venue Management';
                
                field(AvailableVenues; AvailableVenuesCount)
                {
                    Caption = 'Available Venues';
                    ApplicationArea = All;
                    DrillDownPageId = "Venue Setup List";
                    
                    trigger OnDrillDown()
                    var
                        VenueSetup: Record "Venue Setup";
                    begin
                        VenueSetup.Reset();
                        VenueSetup.SetRange(Status, VenueSetup.Status::Vaccant);
                        Page.Run(Page::"Venue Setup List", VenueSetup);
                    end;
                }
                
                field(OccupiedVenues; OccupiedVenuesCount)
                {
                    Caption = 'Occupied Venues';
                    ApplicationArea = All;
                    DrillDownPageId = "Venue Setup List";
                    
                    trigger OnDrillDown()
                    var
                        VenueSetup: Record "Venue Setup";
                    begin
                        VenueSetup.Reset();
                        VenueSetup.SetRange(Status, VenueSetup.Status::Occupied);
                        Page.Run(Page::"Venue Setup List", VenueSetup);
                    end;
                }
                
                field(ReservedVenues; ReservedVenuesCount)
                {
                    Caption = 'Reserved Venues';
                    ApplicationArea = All;
                    DrillDownPageId = "Venue Setup List";
                    
                    trigger OnDrillDown()
                    var
                        VenueSetup: Record "Venue Setup";
                    begin
                        VenueSetup.Reset();
                        VenueSetup.SetRange(Status, VenueSetup.Status::Reserved);
                        Page.Run(Page::"Venue Setup List", VenueSetup);
                    end;
                }
                
                field(OutOfOrderVenues; OutOfOrderVenuesCount)
                {
                    Caption = 'Out of Order Venues';
                    ApplicationArea = All;
                    DrillDownPageId = "Venue Setup List";
                    
                    trigger OnDrillDown()
                    var
                        VenueSetup: Record "Venue Setup";
                    begin
                        VenueSetup.Reset();
                        VenueSetup.SetRange(Status, VenueSetup.Status::"Out of Order");
                        Page.Run(Page::"Venue Setup List", VenueSetup);
                    end;
                }
            }
        }
    }
    
    trigger OnOpenPage()
    begin
        CalculateCounts();
    end;
    
    trigger OnAfterGetRecord()
    begin
        CalculateCounts();
    end;
    
    procedure CalculateCounts()
    var
        VenueBooking: Record "Gen-Venue Booking";
        VenueSetup: Record "Venue Setup";
    begin
        // Calculate booking counts
        VenueBooking.Reset();
        VenueBooking.SetRange("Requested By", UserId);
        VenueBooking.SetRange(Status, VenueBooking.Status::New);
        NewBookingsCount := VenueBooking.Count;
        
        VenueBooking.Reset();
        VenueBooking.SetRange(Status, VenueBooking.Status::"Pending Approval");
        PendingApprovalCount := VenueBooking.Count;
        
        VenueBooking.Reset();
        VenueBooking.SetRange(Status, VenueBooking.Status::Approved);
        ApprovedBookingsCount := VenueBooking.Count;
        
        VenueBooking.Reset();
        VenueBooking.SetRange(Status, VenueBooking.Status::Rejected);
        RejectedBookingsCount := VenueBooking.Count;
        
        // Calculate venue counts
        VenueSetup.Reset();
        VenueSetup.SetRange(Status, VenueSetup.Status::Vaccant);
        AvailableVenuesCount := VenueSetup.Count;
        
        VenueSetup.Reset();
        VenueSetup.SetRange(Status, VenueSetup.Status::Occupied);
        OccupiedVenuesCount := VenueSetup.Count;
        
        VenueSetup.Reset();
        VenueSetup.SetRange(Status, VenueSetup.Status::Reserved);
        ReservedVenuesCount := VenueSetup.Count;
        
        VenueSetup.Reset();
        VenueSetup.SetRange(Status, VenueSetup.Status::"Out of Order");
        OutOfOrderVenuesCount := VenueSetup.Count;
    end;
    
    var
        NewBookingsCount: Integer;
        PendingApprovalCount: Integer;
        ApprovedBookingsCount: Integer;
        RejectedBookingsCount: Integer;
        AvailableVenuesCount: Integer;
        OccupiedVenuesCount: Integer;
        ReservedVenuesCount: Integer;
        OutOfOrderVenuesCount: Integer;
}
