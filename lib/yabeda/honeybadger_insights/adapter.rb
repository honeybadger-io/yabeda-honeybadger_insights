# frozen_string_literal: true

require "yabeda/base_adapter"
require "honeybadger"

module Yabeda
  module HoneybadgerInsights
    class Adapter < BaseAdapter
      def register_counter!(counter)
      end

      def perform_counter_increment!(counter, tags, increment)
        record_metric(counter, tags, increment, "counter")
      end

      def register_gauge!(gauge)
      end

      def perform_gauge_set!(gauge, tags, value)
        record_metric(gauge, tags, value, "gauge")
      end

      def register_histogram!(histogram)
      end

      def perform_histogram_measure!(histogram, tags, value)
        record_metric(histogram, tags, value, "histogram")
      end

      private

      # Since Honeybadger Insights records metrics as logs, treat all metrics as events, regardless of type
      def record_metric(metric, tags, value, type)
        Honeybadger.event("metric", {
          name: metric.name,
          value: value,
          tags: tags,
          type: type,
          group: metric.group,
          unit: metric.unit
        }.compact)
      end
    end
  end
end
