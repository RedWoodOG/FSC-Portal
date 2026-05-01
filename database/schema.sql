-- VyreVault Studios Company Portal - Database Schema
-- PostgreSQL Database Schema

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- =====================================================
-- Users & Authentication
-- =====================================================

CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL DEFAULT 'viewer', -- admin, developer, manager, viewer
    avatar_url TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP,
    is_active BOOLEAN DEFAULT true
);

CREATE TABLE sessions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    token VARCHAR(255) UNIQUE NOT NULL,
    expires_at TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ip_address VARCHAR(45),
    user_agent TEXT
);

CREATE INDEX idx_sessions_user_id ON sessions(user_id);
CREATE INDEX idx_sessions_token ON sessions(token);
CREATE INDEX idx_sessions_expires_at ON sessions(expires_at);

-- =====================================================
-- Projects
-- =====================================================

CREATE TABLE projects (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(255) UNIQUE NOT NULL,
    description TEXT,
    status VARCHAR(50) NOT NULL DEFAULT 'planning', -- planning, active, on-hold, completed, archived
    owner_id UUID NOT NULL REFERENCES users(id),
    repository_url TEXT,
    documentation_url TEXT,
    location_lat DECIMAL(10, 8), -- For spatial mapping
    location_lng DECIMAL(11, 8),
    location_name VARCHAR(255), -- Human-readable location
    health_score INTEGER DEFAULT 100, -- 0-100 project health indicator
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    started_at TIMESTAMP,
    completed_at TIMESTAMP
);

CREATE TABLE project_members (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    project_id UUID NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    role VARCHAR(50) NOT NULL DEFAULT 'contributor', -- owner, lead, contributor, viewer
    joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(project_id, user_id)
);

CREATE TABLE project_milestones (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    project_id UUID NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    due_date TIMESTAMP,
    completed_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_projects_status ON projects(status);
CREATE INDEX idx_projects_owner_id ON projects(owner_id);
CREATE INDEX idx_project_members_project_id ON project_members(project_id);
CREATE INDEX idx_project_members_user_id ON project_members(user_id);
CREATE INDEX idx_project_milestones_project_id ON project_milestones(project_id);

-- =====================================================
-- Resources & Assets
-- =====================================================

CREATE TABLE resource_types (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(100) UNIQUE NOT NULL, -- code_library, design_asset, documentation, tool, template
    description TEXT
);

CREATE TABLE resources (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(255) UNIQUE NOT NULL,
    description TEXT,
    type_id UUID NOT NULL REFERENCES resource_types(id),
    location TEXT, -- URL, file path, or storage location
    file_path TEXT, -- For uploaded files
    file_size BIGINT,
    mime_type VARCHAR(100),
    tags TEXT[], -- Array of tags for searchability
    qr_code TEXT, -- QR code identifier for physical assets
    sku VARCHAR(100), -- Stock keeping unit for inventory
    version VARCHAR(50),
    is_active BOOLEAN DEFAULT true,
    usage_count INTEGER DEFAULT 0,
    created_by UUID REFERENCES users(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE resource_versions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    resource_id UUID NOT NULL REFERENCES resources(id) ON DELETE CASCADE,
    version VARCHAR(50) NOT NULL,
    file_path TEXT,
    changelog TEXT,
    created_by UUID REFERENCES users(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(resource_id, version)
);

CREATE TABLE resource_dependencies (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    resource_id UUID NOT NULL REFERENCES resources(id) ON DELETE CASCADE,
    depends_on_resource_id UUID NOT NULL REFERENCES resources(id) ON DELETE CASCADE,
    dependency_type VARCHAR(50), -- requires, uses, extends
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(resource_id, depends_on_resource_id)
);

CREATE INDEX idx_resources_type_id ON resources(type_id);
CREATE INDEX idx_resources_tags ON resources USING GIN(tags);
CREATE INDEX idx_resources_created_by ON resources(created_by);
CREATE INDEX idx_resource_versions_resource_id ON resource_versions(resource_id);

-- =====================================================
-- Team & Presence
-- =====================================================

CREATE TABLE team_profiles (
    user_id UUID PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE,
    bio TEXT,
    skills TEXT[], -- Array of skill tags
    expertise_areas TEXT[], -- Array of expertise domains
    current_projects UUID[], -- Array of project IDs
    availability_status VARCHAR(50) DEFAULT 'available', -- available, busy, away, offline
    timezone VARCHAR(50),
    github_username VARCHAR(100),
    linkedin_url TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE presence_logs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    status VARCHAR(50) NOT NULL, -- online, away, busy, offline
    last_seen TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    source VARCHAR(50), -- portal, flo, manual
    UNIQUE(user_id)
);

CREATE INDEX idx_presence_logs_user_id ON presence_logs(user_id);
CREATE INDEX idx_presence_logs_last_seen ON presence_logs(last_seen);

-- =====================================================
-- Clients & Contracts
-- =====================================================

CREATE TABLE clients (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(255) UNIQUE NOT NULL,
    contact_email VARCHAR(255),
    contact_phone VARCHAR(50),
    company_url TEXT,
    address TEXT,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE client_projects (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    client_id UUID NOT NULL REFERENCES clients(id) ON DELETE CASCADE,
    project_id UUID NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
    contract_start DATE,
    contract_end DATE,
    contract_value DECIMAL(12, 2),
    payment_terms TEXT,
    status VARCHAR(50) DEFAULT 'active', -- active, completed, terminated, expired
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(client_id, project_id)
);

CREATE TABLE contract_milestones (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    client_project_id UUID NOT NULL REFERENCES client_projects(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    due_date DATE NOT NULL,
    deliverable TEXT,
    completed_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE client_communications (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    client_id UUID NOT NULL REFERENCES clients(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES users(id),
    communication_type VARCHAR(50), -- email, call, meeting, note
    subject VARCHAR(255),
    content TEXT,
    occurred_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_client_projects_client_id ON client_projects(client_id);
CREATE INDEX idx_client_projects_project_id ON client_projects(project_id);
CREATE INDEX idx_contract_milestones_client_project_id ON contract_milestones(client_project_id);
CREATE INDEX idx_contract_milestones_due_date ON contract_milestones(due_date);
CREATE INDEX idx_client_communications_client_id ON client_communications(client_id);

-- =====================================================
-- Inventory & Infrastructure
-- =====================================================

CREATE TABLE inventory_items (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    sku VARCHAR(100) UNIQUE,
    qr_code TEXT UNIQUE,
    category VARCHAR(100), -- hardware, license, infrastructure, equipment
    description TEXT,
    location VARCHAR(255), -- Physical or logical location
    status VARCHAR(50) DEFAULT 'available', -- available, in_use, maintenance, retired
    purchase_date DATE,
    purchase_cost DECIMAL(10, 2),
    current_value DECIMAL(10, 2),
    vendor VARCHAR(255),
    warranty_expires DATE,
    assigned_to UUID REFERENCES users(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE licenses (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    license_key TEXT,
    vendor VARCHAR(255),
    type VARCHAR(100), -- software, subscription, service
    seats INTEGER DEFAULT 1,
    cost_per_seat DECIMAL(10, 2),
    purchase_date DATE,
    renewal_date DATE,
    auto_renew BOOLEAN DEFAULT false,
    status VARCHAR(50) DEFAULT 'active', -- active, expired, cancelled
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE license_assignments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    license_id UUID NOT NULL REFERENCES licenses(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    assigned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    unassigned_at TIMESTAMP,
    UNIQUE(license_id, user_id)
);

CREATE INDEX idx_inventory_items_category ON inventory_items(category);
CREATE INDEX idx_inventory_items_status ON inventory_items(status);
CREATE INDEX idx_inventory_items_assigned_to ON inventory_items(assigned_to);
CREATE INDEX idx_licenses_renewal_date ON licenses(renewal_date);
CREATE INDEX idx_license_assignments_license_id ON license_assignments(license_id);
CREATE INDEX idx_license_assignments_user_id ON license_assignments(user_id);

-- =====================================================
-- Workflows & Automation (A9n Integration)
-- =====================================================

CREATE TABLE workflows (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    description TEXT,
    workflow_id VARCHAR(255), -- External A9n workflow ID
    status VARCHAR(50) DEFAULT 'active', -- active, paused, error, completed
    last_executed_at TIMESTAMP,
    execution_count INTEGER DEFAULT 0,
    success_count INTEGER DEFAULT 0,
    error_count INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE workflow_executions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    workflow_id UUID NOT NULL REFERENCES workflows(id) ON DELETE CASCADE,
    execution_id VARCHAR(255), -- External A9n execution ID
    status VARCHAR(50) NOT NULL, -- running, completed, failed, cancelled
    started_at TIMESTAMP NOT NULL,
    completed_at TIMESTAMP,
    duration_ms INTEGER,
    error_message TEXT,
    input_data JSONB,
    output_data JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_workflows_status ON workflows(status);
CREATE INDEX idx_workflow_executions_workflow_id ON workflow_executions(workflow_id);
CREATE INDEX idx_workflow_executions_status ON workflow_executions(status);
CREATE INDEX idx_workflow_executions_started_at ON workflow_executions(started_at);

-- =====================================================
-- System & Configuration
-- =====================================================

CREATE TABLE system_settings (
    key VARCHAR(255) PRIMARY KEY,
    value TEXT,
    type VARCHAR(50), -- string, number, boolean, json
    description TEXT,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_by UUID REFERENCES users(id)
);

CREATE TABLE audit_logs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES users(id),
    action VARCHAR(100) NOT NULL, -- create, update, delete, view, login, logout
    resource_type VARCHAR(100), -- project, resource, user, etc.
    resource_id UUID,
    changes JSONB, -- Before/after state for updates
    ip_address VARCHAR(45),
    user_agent TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_audit_logs_user_id ON audit_logs(user_id);
CREATE INDEX idx_audit_logs_resource ON audit_logs(resource_type, resource_id);
CREATE INDEX idx_audit_logs_created_at ON audit_logs(created_at);

-- =====================================================
-- Notifications & Alerts
-- =====================================================

CREATE TABLE notifications (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    type VARCHAR(50) NOT NULL, -- alert, info, warning, success
    title VARCHAR(255) NOT NULL,
    message TEXT,
    link TEXT, -- URL to related resource
    is_read BOOLEAN DEFAULT false,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE alert_rules (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    description TEXT,
    rule_type VARCHAR(100), -- contract_expiring, milestone_due, license_expiring, etc.
    conditions JSONB, -- Rule conditions
    notification_template TEXT,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_notifications_user_id ON notifications(user_id);
CREATE INDEX idx_notifications_is_read ON notifications(is_read);
CREATE INDEX idx_notifications_created_at ON notifications(created_at);

-- =====================================================
-- Functions & Triggers
-- =====================================================

-- Update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Apply updated_at triggers to relevant tables
CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON users
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_projects_updated_at BEFORE UPDATE ON projects
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_resources_updated_at BEFORE UPDATE ON resources
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_team_profiles_updated_at BEFORE UPDATE ON team_profiles
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_client_projects_updated_at BEFORE UPDATE ON client_projects
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- =====================================================
-- Initial Data (Seeds)
-- =====================================================

-- Resource Types
INSERT INTO resource_types (name, description) VALUES
    ('code_library', 'Reusable code libraries and components'),
    ('design_asset', 'Design files, templates, and visual assets'),
    ('documentation', 'Documentation, guides, and knowledge base articles'),
    ('tool', 'Development tools and utilities'),
    ('template', 'Project templates and boilerplates'),
    ('hardware', 'Physical hardware and equipment');

-- System Settings
INSERT INTO system_settings (key, value, type, description) VALUES
    ('portal_name', 'VyreVault Studios Portal', 'string', 'Portal display name'),
    ('maintenance_mode', 'false', 'boolean', 'Enable maintenance mode'),
    ('session_timeout', '3600', 'number', 'Session timeout in seconds');
