# frozen_string_literal: true

require "spec_helper"
require "honeybadger/agent"

RSpec.describe Yabeda::HoneybadgerInsights do
  before do
    allow(Honeybadger).to receive(:event)
  end

  after do
    Yabeda.reset!
  end

  it "has a version number" do
    expect(Yabeda::HoneybadgerInsights::VERSION).not_to be nil
  end

  describe "with simple config" do
    before do
      Yabeda.configure do
        group :test do
          counter :steps, comment: "Step counter", tags: [:name]
          gauge :temperature, comment: "Surface temperature", tags: [:color]
          histogram :duration, comment: "Request duration", tags: [:path], buckets: [1, 5, 10]
        end
      end

      Yabeda.register_adapter(:honeybadger_insights, Yabeda::HoneybadgerInsights::Adapter.new)
      Yabeda.configure!
    end

    it "increments a counter" do
      Yabeda.test.steps.increment({name: "Alice"})
      expect(Honeybadger).to have_received(:event)
        .with("metric", hash_including({
          group: :test,
          name: :steps,
          tags: {name: "Alice"},
          type: "counter",
          value: 1
        }))
    end

    it "sets a gauge" do
      Yabeda.test.temperature.set({color: "blue"}, 99)
      expect(Honeybadger).to have_received(:event)
        .with("metric", hash_including({
          group: :test,
          name: :temperature,
          tags: {color: "blue"},
          type: "gauge",
          value: 99
        }))
    end

    it "records a histogram" do
      Yabeda.test.duration.measure({path: "/health"}, 1.2)
      expect(Honeybadger).to have_received(:event)
        .with("metric", hash_including({
          group: :test,
          name: :duration,
          tags: {path: "/health"},
          type: "histogram",
          value: 1.2
        }))
    end
  end

  describe "with default tag" do
    before do
      Yabeda.configure do
        default_tag :global_tag, "custom_global_tag"

        group :test do
          counter :steps, comment: "Step counter", tags: [:name]
          gauge :temperature, comment: "Surface temperature", tags: [:color]
          histogram :duration, comment: "Request duration", tags: [:path], buckets: [1, 5, 10]
        end
      end

      Yabeda.register_adapter(:honeybadger_insights, Yabeda::HoneybadgerInsights::Adapter.new)
      Yabeda.configure!
    end

    it "increments a counter" do
      Yabeda.test.steps.increment({name: "Alice"})
      expect(Honeybadger).to have_received(:event)
        .with("metric", hash_including({
          group: :test,
          name: :steps,
          tags: {name: "Alice", global_tag: "custom_global_tag"},
          type: "counter",
          value: 1
        }))
    end

    it "sets a gauge" do
      Yabeda.test.temperature.set({color: "blue"}, 99)
      expect(Honeybadger).to have_received(:event)
        .with("metric", hash_including({
          group: :test,
          name: :temperature,
          tags: {global_tag: "custom_global_tag", color: "blue"},
          type: "gauge",
          value: 99
        }))
    end

    it "records a histogram" do
      Yabeda.test.duration.measure({path: "/health"}, 1.2)
      expect(Honeybadger).to have_received(:event)
        .with("metric", hash_including({
          group: :test,
          name: :duration,
          tags: {global_tag: "custom_global_tag", path: "/health"},
          type: "histogram",
          value: 1.2
        }))
    end
  end

  describe "with custom unit" do
    before do
      Yabeda.configure do
        group :test do
          counter :planted, comment: "Seeds planted", tags: [:name], unit: "rows"
          gauge :temperature, comment: "Surface temperature", tags: [:color], unit: "degrees"
          histogram :duration, comment: "Request duration", tags: [:path], buckets: [1, 5, 10], unit: "ms"
        end
      end

      Yabeda.register_adapter(:honeybadger_insights, Yabeda::HoneybadgerInsights::Adapter.new)
      Yabeda.configure!
    end

    it "increments a counter" do
      Yabeda.test.planted.increment({name: "Alice"})
      expect(Honeybadger).to have_received(:event)
        .with("metric", hash_including({
          group: :test,
          name: :planted,
          tags: {name: "Alice"},
          type: "counter",
          unit: "rows",
          value: 1
        }))
    end

    it "sets a gauge" do
      Yabeda.test.temperature.set({color: "blue"}, 99)
      expect(Honeybadger).to have_received(:event)
        .with("metric", hash_including({
          group: :test,
          name: :temperature,
          tags: {color: "blue"},
          type: "gauge",
          unit: "degrees",
          value: 99
        }))
    end

    it "records a histogram" do
      Yabeda.test.duration.measure({path: "/health"}, 1.2)
      expect(Honeybadger).to have_received(:event)
        .with("metric", hash_including({
          group: :test,
          name: :duration,
          tags: {path: "/health"},
          type: "histogram",
          unit: "ms",
          value: 1.2
        }))
    end
  end
end
