<<<<<<< HEAD
# billetto_rfc
=======
# Billetto RFC Domain Example

A Ruby on Rails implementation based on the attached **Developer's Guide**. The guide describes a domain-oriented architecture using modules, domain events, commands/command handlers, a command bus, process managers, integrators, read models, thin controllers, asynchronous webhooks, and ACL-style third-party integrations.

Source guidance: the attached document defines a `Guidelines` domain module under `app/domain`, registers its subscriptions with `ApplicationSubscriptions`, models RFC domain events, sends commands through a command bus, and keeps controllers thin. fileciteturn0file0L4-L24

## What is implemented

- `Guidelines` domain module
- RFC aggregate (`RequestForComment`)
- Domain facts: `RfcIssued`, `RfcApprovedByDeveloper`, `RfcApproved`
- Self-executing `ApproveByDeveloper` command
- `IssueRequestForComment` and `ApproveRequestForComment` commands handled by `Guidelines::Service`
- Transactional command bus with correlation/causation IDs
- Event store backed by an ActiveRecord table
- Object repository
- Approval process manager that waits for two developer approvals
- Async ClickUp integrator
- Read model counting RFCs issued by developer
- Incoming webhook persistence + Sidekiq job
- ClickUp ACL/integration adapter
- Request specs and domain/service specs

The attached guide specifically describes a two-approval policy example and an async process manager that dispatches an approval command when the policy is satisfied. fileciteturn0file0L151-L183

## Requirements

- Ruby 3.2+
- Rails 7.2+
- SQLite for the default development database
- Redis if running Sidekiq workers

## Setup

```bash
bundle install
bin/rails db:prepare
bin/rails db:seed
bin/rails server
```

In another terminal, for async handlers:

```bash
bundle exec sidekiq -q critical -q default -q low
```

## Example API

Create an RFC:

```bash
curl -X POST http://localhost:3000/rfcs \
  -H 'Content-Type: application/json' \
  -d '{"description":"Introduce a safer deployment workflow","developer_id":"dev-1"}'
```

Approve it as developer 1:

```bash
curl -X POST http://localhost:3000/rfcs/RFC_ID/approvals \
  -H 'Content-Type: application/json' \
  -d '{"developer_id":"dev-1"}'
```

Approve it as developer 2:

```bash
curl -X POST http://localhost:3000/rfcs/RFC_ID/approvals \
  -H 'Content-Type: application/json' \
  -d '{"developer_id":"dev-2"}'
```

After the second approval, the process manager issues `ApproveRequestForComment`, which publishes `RfcApproved` and the ClickUp integrator schedules a backlog task.

## Architecture

```text
HTTP Controller
      |
      v
 Command Bus ---- transaction / correlation / causation
      |
      v
 Command Handler / Aggregate
      |
      v
 Event Store
      |
      +------> Process Manager ------> Command Bus
      |
      +------> Read Model
      |
      +------> Integrator ------> ClickUp ACL
```

The guide recommends that controllers only parse parameters, create commands, and send them to the command bus. fileciteturn0file0L262-L274

## Design notes

This is a self-contained reference implementation rather than a copy of Billetto's private application internals. The PDF describes interfaces and conventions, but does not provide the original application's full command bus/event-store implementation. Where the guide references existing infrastructure such as `Fact`, `Handler`, `ObjectRepository`, and `Command::Executable`, this project supplies small compatible implementations so the example can run independently.

## Tests

```bash
bundle exec rspec
```

## Rebuild the read model

The guide describes rebuilding read models from their event stream. fileciteturn0file0L222-L259

```bash
bin/rails read_models:rebuild_rfc_counts
```
>>>>>>> Initial Billetto rfc project implementation
