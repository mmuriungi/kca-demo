# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview
This is a Business Central AL extension for Appkings Solutions's academic management system, developed by Appkings. The system manages student accommodation, bulk unit registration, and quality assurance surveys.

## Common Development Commands

### Build and Package
```bash
# Build the app (requires Business Central development environment)
alc /project:./ /packagecachepath:./alpackages /assemblyProbingPaths:./bin

# Package the app
alc /project:./ /packagecachepath:./alpackages /assemblyProbingPaths:./bin /out:./Appkings_Karatina_1.0.0.10.app
```

### PowerShell Scripts
```powershell
# Run procedure replacement script (Windows only)
.\replace_proc.ps1
```

## High-Level Architecture

### Module Structure
The codebase is organized into four main modules:

1. **BulkUnits** - Handles bulk registration of academic units/courses
   - Tables store registration headers and details
   - XMLport enables bulk data import
   - Pages provide UI for managing bulk registrations

2. **Hostel** - Comprehensive accommodation management system
   - Room allocation and booking management
   - Inventory tracking for hostel equipment
   - Financial ledger for hostel charges
   - Incident reporting and permissions system
   - Extensive reporting capabilities

3. **DAQA (Data Analytics & Quality Assurance)** - Survey and quality monitoring
   - Survey creation with various question types
   - FAQ management system
   - JavaScript chart visualizations
   - Excel integration for data import/export

4. **CRM (Customer Relationship Management & Marketing)** - Complete CRM and marketing system
   - Centralized customer database with 360-degree view
   - Lead management and nurturing workflows
   - Campaign planning and execution tools
   - Multi-channel marketing capabilities (Email, SMS, Social Media, etc.)
   - Customer service ticketing system
   - Interaction history and communication logging
   - Customer segmentation and targeting
   - Campaign analytics and reporting
   - Support for surveys, feedback, and engagement tracking
   - Demo data generation for testing purposes

### Key Technical Patterns

1. **Naming Conventions**
   - All academic objects prefixed with `ACA-`
   - Object IDs in ranges: 50000-99999 and 52178423-52179117

2. **Common Table Patterns**
   - Audit fields: `User ID`, `Created`, `Date` on most tables
   - No. Series for automatic numbering
   - FlowFields for calculated values (use sparingly for performance)

3. **Data Validation**
   - OnValidate triggers ensure data integrity
   - TableRelation properties maintain referential integrity

4. **Report Architecture**
   - RDLC layouts stored in `/Layouts/` directory
   - Reports follow naming pattern: `[Module]-[Purpose].Report.al`

### Development Notes

- The app.json suppresses numerous AL warnings - review these when adding new code
- Current version: 1.0.0.10, targeting BC 24.0.0.0
- Runtime version: 15.0
- Multiple app versions (.app files) exist in root - latest is version 10

### CRM Module Specifics

- **Table ID Range**: CRM tables use IDs 52179000-52179999 to avoid conflicts
- **Enum IDs**: CRM enums use IDs 50100-50199
- **Demo Data**: Use codeunit "CRM Demo Data Generator" to create test data
- **Customer Types**: Support for Students, Alumni, Faculty, Staff, Parents, Donors, etc.
- **Lead Scoring**: Automatic calculation based on source, engagement, and behavior
- **Campaign Analytics**: Real-time tracking of opens, clicks, conversions
- **Multi-channel Support**: Email, SMS, Social Media, WhatsApp, etc.
- **GDPR Compliance**: Built-in consent tracking and data retention controls

### Testing and Quality
While no formal test framework is apparent, ensure:
- All new tables include proper keys and indexes
- FlowFields are used judiciously (performance impact)
- Maintain consistent naming conventions
- Test data import/export via XMLports thoroughly
- For CRM testing, use the demo data generator to create realistic scenarios
- Test segmentation rules and campaign targeting before production use
- Verify email/SMS opt-in compliance and GDPR requirements