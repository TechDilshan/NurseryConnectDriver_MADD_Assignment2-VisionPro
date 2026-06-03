# NurseryConnect Vision

## MADD Assignment 2 - Part B: Option 02 visionOS App

### Application Name
NurseryConnect Vision

### Platform
visionOS

### Target Device
Apple Vision Pro

### Project Type
Spatial Computing Prototype

---

## 1. Project Overview

NurseryConnect Vision is a visionOS spatial computing application designed as an extension of the NurseryConnect childcare ecosystem.

The application focuses on the Parent role and provides an immersive parent experience using Apple Vision Pro. It allows parents to explore a virtual nursery environment, view child activity information, monitor nursery transport status, and access safety and compliance information through spatial user interfaces.

The concept extends the earlier NurseryConnect transport work by moving beyond a traditional flat screen dashboard and introducing immersive, three-dimensional nursery exploration.

---

## 2. Assignment Option Selected

This project was developed for:

**Part B - Option 02 - visionOS App**

This option requires the design of an immersive spatial computing application using visionOS for Apple Vision Pro.

The app demonstrates:

- Spatial UI elements
- Immersive space
- RealityKit 3D content
- Parent-focused childcare experience
- NurseryConnect ecosystem extension

---

## 3. Concept Summary

The main concept is an immersive parent experience for childcare communication.

Parents can use Apple Vision Pro to:

- Explore a virtual nursery environment
- View classrooms, play areas, dining areas, reading corners, and outdoor garden spaces
- Monitor child transport progress
- View child attendance and activity summaries
- Access safeguarding and emergency information
- Understand the nursery environment before a physical visit

The application is designed to improve parent trust, transparency, and engagement.

---

## 4. Target Audience

### Primary User

Parents and guardians of children attending the nursery.

### Secondary Users

- Prospective parents
- Nursery managers
- Childcare administrators

### User Need

Parents often want better visibility into nursery environments and daily child activities. Physical nursery tours may not always be possible due to time, distance, or scheduling limitations. NurseryConnect Vision addresses this by providing a spatial and immersive digital tour.

---

## 5. Value Proposition for the Childcare Sector

NurseryConnect Vision provides value to the childcare sector by improving communication and transparency between nurseries and parents.

### Benefits

- Increases parent confidence
- Supports remote nursery exploration
- Improves visibility of childcare routines
- Enhances trust in nursery operations
- Provides a modern parent engagement experience
- Supports safeguarding awareness
- Allows parents to understand transport and safety information more clearly

The application demonstrates how spatial computing can be used beyond entertainment and applied to real childcare communication needs.

---

## 6. Core Features

### 6.1 Parent Dashboard

The parent dashboard displays:

- Selected child information
- Room name
- Keyworker name
- Transport status
- Attendance status
- Daily activity summary
- Meal records
- Upcoming nursery events

### 6.2 Immersive Nursery Tour

The nursery tour allows parents to explore:

- Classroom
- Play area
- Dining area
- Outdoor garden
- Reading corner
- Safety desk

Each area includes descriptive information explaining its childcare purpose.

### 6.3 Immersive Space

The application includes an immersive space using visionOS.

In the immersive space, parents can view a miniature nursery model containing different nursery areas. Users can switch between areas and see selected area information.

### 6.4 Transport Tracking

The transport section extends the previous NurseryConnect transport concept.

It includes:

- Vehicle status
- Driver name
- Estimated arrival time
- Route progress
- Children on board
- Approximate location privacy option

### 6.5 Safety and Compliance Center

The safety section includes:

- Safeguarding information
- Emergency contacts
- Incident summary
- Compliance awareness
- Safety notices

### 6.6 Child Activities

The child activity section includes:

- Activity timeline
- Meal schedule
- Attendance records
- Upcoming nursery events

---

## 7. Spatial Computing Features Used

The application uses spatial computing concepts rather than only recreating a flat mobile app.

### Implemented Spatial Features

- visionOS windows
- NavigationSplitView for spatial navigation
- RealityView
- RealityKit-generated 3D nursery objects
- ImmersiveSpace
- Floating information panels
- 3D room representations
- Interactive nursery area selection

### Spatial UX Purpose

The spatial environment helps parents understand the nursery layout and childcare environment in a more natural way than a normal dashboard.

---

## 8. Technologies Used

### Apple Frameworks

- SwiftUI
- RealityKit
- visionOS
- Foundation

### Architecture

- MVVM architecture
- Service-based mock data layer
- Modular folder structure
- Reusable UI components

### 3D Implementation

The prototype uses RealityKit-generated 3D objects rather than external USDZ assets. This makes the project easier to run in the visionOS simulator while still demonstrating 3D content and spatial design.

---

## 9. Project Structure

```text
NurseryConnectVision
│
├── App
│   ├── NurseryConnectVisionApp.swift
│   ├── AppConstants.swift
│   └── AppRouter.swift
│
├── Models
│   ├── Child.swift
│   ├── Parent.swift
│   ├── TransportStatus.swift
│   ├── VehicleStatus.swift
│   ├── NurseryArea.swift
│   ├── SafetyNotice.swift
│   ├── DailyActivity.swift
│   ├── ChildAttendance.swift
│   ├── ChildMeal.swift
│   ├── NurseryEvent.swift
│   └── TourLocation.swift
│
├── Services
│   ├── MockDataService.swift
│   ├── TransportService.swift
│   ├── ParentDashboardService.swift
│   ├── SafetyService.swift
│   ├── TourService.swift
│   └── AssetLoaderService.swift
│
├── ViewModels
│   ├── ParentDashboardViewModel.swift
│   ├── TransportViewModel.swift
│   ├── NurseryTourViewModel.swift
│   ├── SafetyViewModel.swift
│   ├── ChildActivityViewModel.swift
│   └── ImmersiveViewModel.swift
│
├── Views
│   ├── Dashboard
│   ├── NurseryTour
│   ├── Transport
│   ├── Safety
│   ├── Activities
│   ├── Components
│   └── Windows
│
├── ImmersiveSpace
│   ├── NurseryImmersiveView.swift
│   ├── NurseryRealityView.swift
│   └── ImmersiveControlsView.swift
│
├── RealityKit
│   ├── NurseryEntity.swift
│   ├── ClassroomEntity.swift
│   ├── PlaygroundEntity.swift
│   ├── DiningEntity.swift
│   ├── GardenEntity.swift
│   └── ChildAvatarEntity.swift
│
├── Utilities
│   ├── DateFormatterHelper.swift
│   ├── Extensions.swift
│   ├── ColorTheme.swift
│   ├── Constants.swift
│   └── PreviewData.swift
│
└── Resources
    ├── Children.json
    ├── Activities.json
    ├── Meals.json
    └── Events.json
